public class QueueableTest implements queueable{

    private Account account;
    
    public QueueableTest(Account account){
        this.account = account;
    }
    public void execute(queueableContext context){
        Contact contact = new Contact();
        contact.LastName = 'Contact';
        contact.AccountId = account.Id;
        insert contact;
        
        String latestContactName = contact.LastName;
        account.Description = latestContactName;
        
        update account;
    }
    
}