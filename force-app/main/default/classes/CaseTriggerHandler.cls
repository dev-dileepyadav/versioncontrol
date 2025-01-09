public with sharing class CaseTriggerHandler {
    // Consumer secrat - 159E5DEEDA4B18A0A14C5FF00FA1979A9C0E22B2C1C419FB917C8BCE30F6CA69
    // Consumer key - 3MVG9WVXk15qiz1Kw4fbhn86Mw6_.B6BgXNRA0bmzn6IuMWO.kmR1oW9QL7KzJQtKvn.p8K9yfDCHLCuI9OIw
    /*https://login.salesforce.com/services/oauth2/authorize?
client_id=3MVG9WVXk15qiz1Kw4fbhn86Mw6_.B6BgXNRA0bmzn6IuMWO.kmR1oW9QL7KzJQtKvn.p8K9yfDCHLCuI9OIw&
redirect_uri=https://dssda-dev-ed.develop.lightning.force.com/oauth2/callback&
response_type=code

To get access token

https://login.salesforce.com/services/oauth2/authorize?client_id=3MVG9WVXk15qiz1Kw4fbhn86Mw6_.B6BgXNRA0bmzn6IuMWO.kmR1oW9QL7KzJQtKvn.p8K9yfDCHLCuI9OIw&redirect_uri=https://dssda-dev-ed.develop.lightning.force.com/&response_type=token


this is result URL of above call

https://xdxfd-dev-ed.develop.my.salesforce.com/#access_token=00DdM000006TF1s%21AQEAQJ4L5Z08yZFBWZJa1LSwgwXUsT_eGGsJc99Dnd088hI3tiG5xlzG.3IuN0EWDXQF0zbUY37ZjhN5YvZDvNtufVwnxV5f&instance_url=https%3A%2F%2Fdssda-dev-ed.develop.my.salesforce.com&id=https%3A%2F%2Flogin.salesforce.com%2Fid%2F00DdM000006TF1sUAG%2F005dM0000045ysUQAQ&issued_at=1722306045980&signature=JVmX2et9e740bwAYwT7wEZC6zPSbKWTlNsUUdF8mYG8%3D&scope=api+web+full&token_type=Bearer
*/



    public static void handleAfterInsert(List<Case> newRecords){

        if(System.isFuture() || System.isBatch()){
            return;
        }

        for(Case ca : newRecords){
            ZendeskIntegrationUtilsl.TicketWrapper wrapper = new ZendeskIntegrationUtilsl.TicketWrapper();
            wrapper.name = 'Dileep Yadav';
            wrapper.subject = 'This is from APEX Class';
            wrapper.body = ca.Description;
            wrapper.priority = 'High';
            wrapper.email = ca.SuppliedEmail;
            // Converting object into the string
            makeCallout(JSON.serialize(wrapper));
        }
        
    }

    @future(callout = true)
    private static void makeCallout(String params){
        // Converting the string into the object(class)
        // (Convering JSON into the object is often required for Apex-Callouts
        // (JSON is just a string, but the object is not).
        // This is the object that we are going to send to the API
        ZendeskIntegrationUtilsl.TicketWrapper wrapper = (ZendeskIntegrationUtilsl.TicketWrapper)JSON.deserialize(params, ZendeskIntegrationUtilsl.TicketWrapper.class);
        ZendeskIntegrationUtilsl.createTicket(wrapper);
    }

    public static void syncCaseStatusWithFedlinkStatus(List<Case> cases){

        for(Case cse : cases){
            
                cse.Description = cse.Status;
            
            
    }
}


public static void updateCaseStatusWithFedlinkStatus(List<Case> cases,Map<Id,Case> oldCases){
    for(Case cse : cases){
        if(cse.Status != oldCases.get(cse.Id).Status){
            cse.Description = cse.Status;
        }
    }
}
}