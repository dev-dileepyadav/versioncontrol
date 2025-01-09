public with sharing class ZendeskCaseTriggerHandler {
   

    public static void handleAfter(List<Case> newCases){

        for(Case cs : newCases){
            ZendeskCreateTicket.TicketWrapper ticketWrap = new ZendeskCreateTicket.TicketWrapper();
                ticketWrap.body = cs.Description;
                ticketWrap.priority = cs.Priority.toLowerCase();
                ticketWrap.subject = cs.Subject;
                // Converting Object into String
                makeCallOut(JSON.serialize(ticketWrap));
        }

    }

    @future(callout = true)
    private static void makeCallOut(String params){
// Converting String in to object
        ZendeskCreateTicket.TicketWrapper wrapper = (ZendeskCreateTicket.TicketWrapper)JSON.deserialize(params, ZendeskCreateTicket.TicketWrapper.class);
        ZendeskCreateTicket.createTicket(wrapper);
    }
}