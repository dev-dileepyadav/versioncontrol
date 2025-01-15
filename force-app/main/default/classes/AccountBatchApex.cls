global class AccountBatchApex implements Database.Batchable<sObject>,database.stateful {
    
    String csvString;
    
        
    global Database.QueryLocator start(Database.BatchableContext BC) {
        // collect the batches of records or objects to be passed to execute
         String query = 'SELECT Id,Name FROM Account';
        
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Account> accList) {
       
        // process each batch of records
        List<String> accountIds = new List<String>();
        
        for(Account acc : accList){        
              accountIds.add(acc.id);
        }
        
        List<contact> contacts = [SELECT Id FROM contact WHERE AccountId =: accountIds];
        
        System.debug('Contacts'+contacts);
        for(contact con : contacts){
            csvString = csvString+ con.id+'\n';
         }
    }
    global void finish(Database.BatchableContext BC){
        try{
        Messaging.EmailFileAttachment csvFile = new Messaging.EmailFileAttachment();
        Messaging.singleEmailMessage email = new Messaging.singleEmailMessage();
        System.debug('Csv String'+csvString);
        csvFile.setFileName('ContactsId.csv');
        csvFile.setBody(blob.valueOf(csvString));
        //csvFile.setBody(attachmentBody);
        email.setToAddresses(new List<String>{'dileepyadav60@gmail.com'});
        email.setSubject('Contacts Id');
        email.setFileAttachments(new List<Messaging.EmailFileAttachment>{csvFile});
        email.setPlaintextbody('Please find the required contacts Id');
        Messaging.sendEmail(new List<Messaging.singleEmailMessage>{email});
            
        }catch(Exception e){
            System.debug('Email exception '+e.getMessage());
        }
  }
 }