public class SendAttachedEmail {

    public static void sendEmail(){
        String dataToSend;
        Messaging.EmailFileAttachment csvFile = new Messaging.EmailFileAttachment();
        Messaging.singleEmailMessage email = new Messaging.singleEmailMessage();

        for(Account account : [SELECT Id, Name, Type, Phone, Fax, AccountNumber, Website, Industry FROM Account LIMIT 10]){
            dataToSend = dataToSend+account.Name+account.Type+account.Phone+account.Fax+'\n';
            System.debug('Data To Send'+dataToSend);
                csvFile.setFileName('account data.csv');
            csvFile.setContentType('application/pdf');
        csvFile.setBody(blob.valueOf(dataToSend));
        email.setToAddresses(new List<String>{'dileepyadav60@gmail.com'});
        email.setSubject('Contacts Id');
        email.setFileAttachments(new List<Messaging.EmailFileAttachment>{csvFile});
        email.setPlaintextbody('Please find the required contacts Id');
        }
        Messaging.sendEmail(new List<Messaging.singleEmailMessage>{email});
    }
}