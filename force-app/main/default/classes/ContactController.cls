public with sharing class ContactController {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactsForCustomDataTable(){
         List<Contact> contacts = [SELECT Id,Name,Phone,Email,title,Leadsource FROM contact WHERE AccountId != null];

         return contacts;

    }
    @AuraEnabled
    public static string SendEmail(List<Id> contactIds){
        
        List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();
        String subject = 'Test Email From Lightning  Data Table';
        String body = 'This is the message body.';
        for(Contact contact : [SELECT Id,Name,Email,Phone FROM Contact WHERE Id In : contactIds]){
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setToAddresses(new List<String>{contact.Email});
            message.setSubject(subject);
            message.setplainTextBody(body);
            messages.add(message);
    }
    try{
        Messaging.SendEmail(messages);
        return 'Email sent';
    }catch(Exception e){
        return 'Can Not Send email';
    }
}
    

    @AuraEnabled(cacheable=true)
    public static List<contactWrapper> wrapperContacts(){

        List<contactWrapper> conWrappers = new List<contactWrapper>();
        for(contact contacts : [SELECT Id,Account.Name,FirstName,LastName,Title,Email,Phone,Leadsource,
        (SELECT Id FROM Cases) FROM Contact ]){
            contactWrapper conWrapper = new contactWrapper();
            conWrapper.Id = contacts.Id;
            conWrapper.accountName = contacts.Account.Name;
            conWrapper.FirstName = contacts.FirstName;
            conWrapper.LastName = contacts.LastName;
            conWrapper.Email = contacts.Email;
            conWrapper.Phone = contacts.Phone;
            conWrapper.Title = contacts.Title;
            conWrapper.caseCount = contacts.cases.size();
            if (contacts.Leadsource == 'Phone Inquiry' && String.isBlank(contacts.Phone)) {
                conWrapper.isBadContact = true;
            }else{
                conWrapper.isBadContact = false;
            }
            conWrappers.add(conWrapper);
        }
        return conWrappers;
    }

    public class contactWrapper{
        @AuraEnabled
        public String FirstName;
        
        @AuraEnabled
        public String LastName;

        @AuraEnabled
        public String Email;

        @AuraEnabled
        public String Phone;

        @AuraEnabled
        public String Title;

        @AuraEnabled
        public boolean isBadContact;

        @AuraEnabled
        public Integer caseCount;

        @AuraEnabled
        public String Id;

        @AuraEnabled
        public String accountName;
        
    }
}