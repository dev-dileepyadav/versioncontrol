@isTest
public class DocumentHandlerTest {

    @testSetup
    static void setupData() {

        // Create a Closed Won Opportunity
        Opportunity testOpp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Closed Won',
            CloseDate = Date.today());
        
        insert testOpp;

        // Create a ContentDocument and ContentDocumentLink for the Opportunity
        ContentVersion contentVersion = new ContentVersion(
            Title = 'Test File',
            PathOnClient = 'testfile.pdf',
            VersionData = Blob.valueOf('Test file content')
        );
        insert contentVersion;

        // Link ContentDocument to Opportunity
       ContentVersion document = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :contentVersion.Id LIMIT 1];
        ContentDocumentLink docLink = new ContentDocumentLink(
            ContentDocumentId = document.ContentDocumentId,
            LinkedEntityId = testOpp.Id,
            ShareType = 'V'
        );
        insert docLink;
    }

    
    @isTest
    static void testSendEmail() {
        // Retrieve ContentDocumentLink records created during test setup
        Opportunity opps = [SELECT ID,Name FROM Opportunity WHERE Name = 'Test Opportunity' LIMIT 1];
        List<ContentDocumentLink> newFiles = [SELECT Id, LinkedEntityId, ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId =:opps.Id];

        // Call the method under test
        Test.startTest();
        DocummentHandler.sendEmail(newFiles);
        Test.stopTest();

        List<EmailMessage> sentEmails = [SELECT Subject, ToAddress FROM EmailMessage];
        //System.assertEquals(1, sentEmails.size(), 'One email should have been sent.');
        System.assertEquals('New File Added to Your Opportunity', sentEmails[0].Subject, 'Subject should match the Opportunity Name.');
    }
}