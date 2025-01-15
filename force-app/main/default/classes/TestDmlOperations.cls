@isTest
public class TestDmlOperations {

    @isTest
    public static void createRecord(){
        test.startTest();
        DmlOperations.createAccount('Dileep','Test account created by Dileep yadav');
        test.stopTest();
        
        List<Account> accList = [SELECT Id,Name FROM Account WHERE name ='Dileep'];
        system.assertEquals(1,accList.size());
    }
    
    @isTest
    public static void updatetast(){
        
        List<account> accList = new List<Account>();
        for(Integer i = 0; i<100; i++){
            Account acc = new Account();
            acc.name = 'test'+i;
            accList.add(acc);
        }
        insert accList;
        
        List<Account> accounts = [SELECT id,name,phone from Account WHERE phone = null];
        test.startTest();
        DmlOperations.updateAccounts();
        test.stopTest();
        
        System.assertEquals(null, accounts[0].phone);
    }
    
    @isTest
    public static void deleteOperations(){
        List<Account> accList = new List<Account>();
        for(integer i = 0; i<100;i++){
            Account acc = new Account();
            acc.name = 'test'+i;
            accList.add(acc);
        }
        insert accList;
        
       test.startTest();
        DmlOperations.deleteOperations();
        test.stopTest();
        
        List<Account> Accounts = [SELECT Id,name,Phone FROM Account WHERE phone = null];
        system.assertEquals(0,Accounts.size());
    }
}