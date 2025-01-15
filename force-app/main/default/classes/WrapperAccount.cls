public class WrapperAccount {

    public static List<wrap> getrelatedContacts(){
         List<wrap> wrapList = new List<wrap>();
    
    List<Account> accList = [SELECT Id,Name,Phone,(SELECT Id,LastName,FirstName,email,Phone FROM Contacts) FROM Account];
    
    for(Account acc  :accList){
        wrapList.add(new wrap(acc,acc.contacts));
    }
        return wrapList;
    }
    
    
    public class wrap{
        public Account acc{get;set;}
        public List<contact> contacts{get;set;}
        
        public wrap(Account acc, List<contact> contacts){
            this.acc = acc;
            this.contacts = contacts;
            System.debug('Account'+this.acc);
            System.debug('Contacts'+this.contacts);
        }
    }
}