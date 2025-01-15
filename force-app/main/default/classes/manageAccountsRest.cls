@RestResource(urlMapping = '/accountManagment/')
global class manageAccountsRest {

    @httpGet
    global static List<Account> getAccounts(){
        Map<String,String> parammap = Restcontext.request.params;
        System.debug('Map Data'+parammap);
        List<Account> accList = [SELECT Id,Name,Phone FROM Account WHERE id =: parammap.get('id')];
        return accList;
    }
    
    @httpdelete
    global static String deleteAccount(){
        map<String,String> parMap = RestContext.request.params;
        
        account acc = [SELECT id,Name FROM Account WHERE id=: parMap.get('id')];
        delete acc;
        return 'Record deleetd';
    }
    
    @httpPost
    global static Account postData(accountsInfo accountInfo){
        Account acc = accountInfo.acc;
        insert acc;
        return acc;
    }
    
    @httpPut
    global static Account updateAccount(String name){
        map<String,String> parMap = RestContext.request.params;
        Account acc = new Account();
        acc.Id = parmap.get('id');
        acc.name = name;
        update acc;
        return acc;
    }
    
    global class accountsInfo{
        Account acc{get;set;}
    }
}









/*
 post data in XML format using wrapper class

<request>
<accountInfo>
<acc>
<name>Wrapper testing</name>
<phone>12345685</phone>
</acc>
</accountInfo>

</request>

post data in JSON format using wrapper class

{
"accountInfo" : {
"acc" : {
"name" : "JSON test"
}
}
}

*/