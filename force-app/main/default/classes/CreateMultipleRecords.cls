public class CreateMultipleRecords {

    public static void createContacts(String five9AddToList){
        
        List<Contact> Contacts = new List<Contact>();
        for(Integer i = 0; i<100;i++){
            Contact contact = new Contact();
                contact.FirstName = 'First ';
                contact.LastName = 'Last '+i;
                contact.Add_to_f9list_id__c = five9AddToList;
                Contacts.add(contact);
            
        }
        insert Contacts;
    }
    
    public static void createEvent(String LeadId){
        List<Event> Events = new List<Event>();
        for(Integer i = 0; i<5;i++){
            Event Event = new Event();
                Event.Subject = 'Existing Customer Meeting';
                Event.whoId = LeadId;
            Event.ActivityDate = System.today();
            Event.DurationInMinutes = 10;
            Event.ActivityDateTime = System.now();
                Events.add(Event);
            
            
        }
        insert Events;
    }
}