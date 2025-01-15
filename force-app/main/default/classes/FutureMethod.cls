public class FutureMethod {

    @future
    public static void countnumberOfContacts(List<id> idList){
        List<Account> accList = [SELECT Id,total_contacts__c,(SELECT id,lastname FROM contacts) FROM Account WHERE id =: idList];
        
        for(Account acc: accList){
            acc.total_contacts__c = acc.contacts.size();
        }
        update accList;
    }
}