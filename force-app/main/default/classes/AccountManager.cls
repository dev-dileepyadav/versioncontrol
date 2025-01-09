@RestResource(urlMapping = '/createAccount/*')
global class AccountManager {
    
    /*
    @httpPost
    global static String createAccount(AccountWrapper accountDetails){
        Account newAccount = new Account();
        newAccount.Name = accountDetails.Name;
        newAccount.Phone = accountDetails.Phone;
        newAccount.website = accountDetails.website;

        insert newAccount;
        return newAccount.Id;
    }
        */

    @httpGet
    global static Account getAccount(){
        RestRequest req = RestContext.request;
        System.debug(System.JSON.serialize(req));

        RestResponse res = RestContext.response;
        String accountId = req.requestURI.subStringAfterLast('/');
        Account getAccount = [SELECT Id,Name,Industry,Fax,BillingAddress,ShippingAddress FROM Account WHERE Id =: accountId];
        return getAccount;
    }

    @httpDelete
    global static String deleteAccount(){
        RestRequest req = RestContext.request;

        String accountId = req.requestURI.subStringAfterLast('/');
        Account recordToDelete = [SELECT Id FROM Account WHERE Id =: accountId LIMIT 1];
        delete recordToDelete;
        return 'Account Deleted';
    }

    @httpPatch
    global static Account updateAccount(){
        RestRequest req = RestContext.request;

        String accountId = req.requestURI.subStringAfterLast('/');
        String body = req.requestBody.toString();

        Map<String,Object> requestBody = (Map<String,Object>)JSON.deserializeUntyped(body);

        Account updateToAccount = new  Account(Id = accountId);
        updateToAccount.Name = (String)requestBody.get('Name');
        updateToAccount.Phone = (String)requestBody.get('Phone');
        updateToAccount.AnnualRevenue = (Decimal)requestBody.get('Amount');

        update updateToAccount;

        return updateToAccount;
    }
}