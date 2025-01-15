public class AccountWrapper {
    
    public List<accountWrap> wrapAccounts{get;set;}
    public List<Account> accounts{get;set;}
    public List<contact> contacts{get;set;}
    public List<String> accid{get;set;}
    //==================
    public AccountWrapper(){
        wrapAccounts = new List<accountWrap>();
        accounts = new List<Account>();
        contacts = new List<contact>();
        accid = new List<String>();
        
        for(Account account : [SELECT Id,Name,Industry,Phone,Type FROM Account]){
            accountWrap wrap = new accountWrap(account);
            wrapAccounts.add(wrap);
        }
    }
    
    //=====================
    
    public class accountWrap{
        public account acc{get;set;}
        public boolean isSelected{get;set;}
        
        public accountWrap(Account acount){
            acc = acount;
            
        }
        
    }
    //================
    public void addAccounts(){
        accounts.clear();
        for(accountWrap wrapAcc : wrapAccounts){
            if(wrapAcc.isSelected == true){
                accounts.add(wrapAcc.acc);
                accid.add(wrapAcc.acc.id);
                System.debug('Account Id '+wrapAcc.acc.id);
            }
            
        }
    }
    //=================
    public void showContacts(){
        contacts.clear();
        for(accountWrap wrap : wrapAccounts){
            if(wrap.isSelected == true){
                accid.add(wrap.acc.id);
                System.debug('Account Id '+wrap.acc.id);
            }
            
        }
        contacts = [SELECT id,
                    FirstName,
                    LastName,
                    Email,
                    Phone,
                    Account.Name,
                    AccountId 
                    from contact 
                    WHERE AccountId IN : accid];
        system.debug(contacts);
    }

}