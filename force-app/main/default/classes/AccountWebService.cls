@restResource(urlmapping='/accountRest/')
global with sharing class AccountWebService {

    @httpPost
    global static AccountWebserviceWrapper.response createAccount(){
        boolean success = false;
        String message = '';
        if(restContext.request != null){
            String requestBody = restcontext.request.requestBody.toString();
            System.debug('Request body '+requestBody);
            if(String.isNotBlank(requestBody)){
                try{
                    List<AccountWebserviceWrapper.Accounts> accountPayLoad = (List<AccountWebserviceWrapper.Accounts>) JSON.deserialize(requestBody,List<AccountWebserviceWrapper.Accounts>.class);
                    List<Account> accountRecordList = createAccountRecords(accountPayLoad);
                    if(accountRecordList.size() > 0){
                        insert accountRecordList;
                        success = true;
                        message = 'Inserted';
                    }else{
                        success = false;
                        message = 'Not inserted';
                    }
                }catch(exception e){
                    success = false;
                    message = 'Not inserted'+e.getmessage();
                }
            }
            
        }
        AccountWebserviceWrapper.response resp = new AccountWebserviceWrapper.response();
            resp.success = success;
            resp.message = message;
            return resp;
    }
    
    private static List<Account> createAccountRecords(List<AccountWebserviceWrapper.Accounts> accountPayLoad){
        List<Account> accList = new List<Account>();
        for(AccountWebserviceWrapper.Accounts Account : accountPayLoad){
            Account acc = new Account();
            acc.Name = Account.name;
            acc.phone = Account.phone;
            acc.Fax = Account.fax;
            accList.add(acc);
        }
        return accList;
    }
    /*
    @httpget
    global static AccountWebserviceWrapper.getAccountResponse getAccoun(){
        Boolean success = true;
        String message = '';
        List<AccountWebserviceWrapper.Accounts> accountList = null;
        if(restContext.request != null){
            String requestBody = restContext.request.requestBody.toString();
            if(String.isNotEmpty(requestBody)){
                try{
                   AccountWebserviceWrapper.getAccounts accountPayLoad = (AccountWebserviceWrapper.getAccounts)JSON.deserialize(requestBody, AccountWebserviceWrapper.getAccounts.class);
                    accountList = getAccountRecord(accountPayLoad);
                    
                    if(accountList.size() > 0){
                        success = true;
                        message = 'Account records processed';
                        }
                }catch(exception e){
                    success = false;
                        message = 'Account Not records processed'+e.getmessage();
                }
            }
        }
        AccountWebserviceWrapper.getAccountResponse res = new AccountWebserviceWrapper.getAccountResponse();
        res.success = success;
        res.message = message;
        res.accountsList = accList;
        return res;
    }
    
    private static AccountWebserviceWrapper.Accounts getAccountRecord(AccountWebserviceWrapper.getAccounts accountPayLoad){
        List<AccountWebserviceWrapper.Accounts> accList = new List<AccountWebserviceWrapper.Accounts>();
        for(Account acc : [SELECT Id,name,Phone,Fax FROM Account WHERE name =:accountPayLoad.accounts]){
            AccountWebserviceWrapper.Accounts accountQueried = new AccountWebserviceWrapper.Accounts();
            accountQueried.name =  acc.Name;
            accountQueried.fax = acc.Fax;
            accountQueried.phone = acc.Fax;
            accList.add(accountQueried);
        }
        return accList;
    }*/
}