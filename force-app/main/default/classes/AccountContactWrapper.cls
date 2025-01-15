public with sharing class AccountContactWrapper {
    @AuraEnabled
    public static List<AccountContactListWrapper> getAllAccountWithContacts(){
        List<AccountContactListWrapper> accConWrapperList = new List<AccountContactListWrapper>();
        List<Account> accList = [SELECT Id,Name,(SELECT Id,firstName,LastName,Phone,email FROM contacts) FROM Account];
        if(!accList.isEmpty()){
            for(Account acc : accList){
                AccountContactListWrapper accConWrapper = new AccountContactListWrapper();
                accConWrapper.accRecord = acc;
                accConWrapper.conList = acc.contacts;
                accConWrapper.contactCount = acc.contacts.size();
                accConWrapperList.add(accConWrapper);
            }
        }
        return accConWrapperList;
    }

    public class AccountContactListWrapper{
        public account accRecord{get;set;}
        public List<contact> conList{get;set;}
        public Integer contactCount{get;set;}
    }
}