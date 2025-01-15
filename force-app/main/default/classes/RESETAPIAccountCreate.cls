@restResource(urlmapping='/accountcreate/')
global with sharing class  RESETAPIAccountCreate{
    
    @httpPost
    global static RESETAPIAccountCreateWapper.res createAccountRecords(){
        String requestBody = restcontext.request.requestBody.toString();
   
    List<RESETAPIAccountCreateWapper.Ac> accountRecord = (List<RESETAPIAccountCreateWapper.Ac>) JSON.deserialize(requestBody,List<RESETAPIAccountCreateWapper.Ac>.class);
    
        System.debug('AccountRecord'+accountRecord);
        List<Account> accountRecor = createAccountRecords(accountRecord);
    insert accountRecor;
        RESETAPIAccountCreateWapper.res r = new RESETAPIAccountCreateWapper.res();
        r.re = 'success';
        return r;
    }
   
    
    private static List<Account> createAccountRecords(List<RESETAPIAccountCreateWapper.Ac> accountRecords){
        List<Account> accList = new List<Account>();
        for(RESETAPIAccountCreateWapper.Ac acc : accountRecords){
        Account ac = new Account();
        ac.Name = acc.name;
        accList.add(ac);
    }
        return accList;
    }
   /*
    @HttpPost
    global static String CreateAccount(String name,String phone,String website ) {
        Account acc = new Account();
        acc.name= name;
        acc.phone=phone;
        acc.Website =website ;
        insert acc;
        
        return acc.id;
    }*/
}