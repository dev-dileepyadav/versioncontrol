@isTest
public class QueueableTestClass {

    @isTest
    public static void testQueueableMethod(){
        Account testAccount = new Account();
        testAccount.Name = 'Test Account';
        
        insert testAccount;
        
        
        
        Test.startTest();
        QueueableTest queueableJob = new QueueableTest(testAccount);
        system.enqueueJob(queueableJob);
        Test.stopTest();
        
        List<contact> createdContact = [SELECT id,LastName FROM contact WHERE AccountId =: testAccount.Id];
        
        System.assertEquals(1,createdContact.size());
    }
}