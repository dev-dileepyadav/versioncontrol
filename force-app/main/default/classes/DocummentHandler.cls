public class DocummentHandler {

	public static void sendEmail(List<ContentDocumentLink> newFiles){
        Set<id> parentId = new Set<id>();
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for(ContentDocumentLink file : newFiles){
            if(file.LinkedEntityId != null && file.LinkedEntityId.getsObjectType() == Opportunity.getsObjectType()){
                parentId.add(file.LinkedEntityId);
            }
        }
        if(! parentId.isEmpty()){
            List<Opportunity> oppList = [Select id, name, owner.Email from Opportunity where id in: parentId and StageName = 'Closed Won'];
            for(Opportunity opp: oppList){
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new String[] {'test@test.com'});
                email.setSubject('New File Uploaded ' + opp.Name);
            	email.setPlainTextBody('A new file has been uploaded to the Opportunity: ' + opp.Name + '.');
            
            	emails.add(email);
            }
            if(! emails.isEmpty()){
                Messaging.sendEmail(emails);
            }
        }
    }
}