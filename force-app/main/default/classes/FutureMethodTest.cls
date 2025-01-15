@isTest
public class FutureMethodTest {

    @isTest
    private static void countTest(){
        
        // Data setup
        List<Account> accList = new List<Account>();
        for(Integer i = 0;i<=250; i++){
            
            accList.add(new Account(name = 'Test'+i));
        }
         insert accList;
        List<id> accId = new List<id>();
        List<contact> conList = new List<contact>();
        for(Account acc : accList){
            accid.add(acc.id);
            conList.add(new contact(lastname = acc.Name, accountId = acc.Id)); 
        }
        insert conList;
        
        test.startTest();
        FutureMethod.countnumberOfContacts(accid);
        test.stopTest();
        List<Account> acc = [SELECT id,total_contacts__c FROM Account];
        system.assertEquals(1,acc[0].total_contacts__c);
    }
    
}