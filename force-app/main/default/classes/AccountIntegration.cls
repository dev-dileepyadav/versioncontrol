@RestResource(URLMapping='/accountIntegration/')
global class AccountIntegration {

    @httpGet
    global static accountWrapper getTopRatingAccounts(){
        Map<String,String> paramsMap = restContext.request.params;
        String accIndustry = paramsMap.get('Industry');
        String accRating = paramsMap.get('Rating');
        set<id> accIds = new set<Id>();
        List<Account> accounts = [SELECT Id,
                                  Name,
                                  Rating,
                                  AnnualRevenue,
                                  Industry
                                  FROM Account
                                  WHERE AnnualRevenue != null AND Industry =: accIndustry AND Rating =: accRating
                                  ORDER By AnnualRevenue DESC];
    
        for(Account acc : accounts){
            accIds.add(acc.id);
        }
        List<contact> contacts = [SELECT Id,LastName,FirstName,Email,Phone FROM contact WHERE AccountId =: accIds];
        List<Case> cases = [SELECT Id, CaseNumber, ContactId, AccountId, Type, Status, Reason, Subject, Priority FROM Case WHERE AccountId =: accIds];
        
        accountWrapper wrap = new accountWrapper();
        wrap.accounts = accounts;
        wrap.contacts = contacts;
        wrap.cases = cases;
        return wrap;
    }
    /*
    @httpPost
    global static String createAccount(String accName, String accRating, String accIndustry){
        Account acc = new Account();
        acc.Name = accName;
        acc.Rating = accRating;
        acc.Industry = accIndustry;
        try{
            insert acc;
            Return 'Account inserted';
        }catch(exception ex){
            return ex.getMessage();
        }
    }
*/
    
    @httpPost
    global static String createAccountWithContact(accountInformation information){
        Account accRecord = information.accountRecord;
        contact conRecord = information.contactRecord;
        
        try{
            insert accRecord;
            conRecord.AccountId = accRecord.id;
            insert conRecord;
            return 'Account and contact is created successfully';
        }catch(exception ex){
            return ex.getMessage();
        }
    }
    
    @httpDelete
    global static String deleteAccount(){
        Map<String,String> paramsMap = restContext.request.params;
        String accountId = paramsMap.get('accId');
        List<Account> accList = [SELECT id FROM Account WHERE id =: accountId];
        if(!accList.isEmpty()){
            try{
                delete accList;
                return 'Account deleted succuessfully';
            }catch(exception ex){
                return ex.getMessage();
            }
        }else{
            return 'Record Not Found';
        }
        
    }

    global class accountWrapper{
        global List<Account> accounts;
        global List<contact> contacts;
        global List<case> cases;
    } 
    
    global class accountInformation{
        global Account accountRecord{get;set;}
        global Contact contactRecord{get;set;}
    }
}