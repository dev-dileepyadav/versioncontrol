public class ContactTriggerHelper {
    
    public static void avoideInsertContact(List<Contact> contacts){
        Set<Id> accountIds = new Set<Id>();
        for(Contact contact : contacts){
            accountIds.add(contact.AccountId);
        }
        
        Map<Id,Integer> numberOfAccount = new Map<Id,Integer>();
        
        List<AggregateResult> agr = [SELECT accountId, COUNT(Id)contactCount FROM Contact WHERE accountId =: accountIds GROUP BY accountId];
        
        for(AggregateResult ag : agr){
            numberOfAccount.put((Id)ag.get('accountId'),(Integer)ag.get('contactCount'));
        }
        
        for(Contact con : contacts){
            if(numberOfAccount.get(con.AccountId) >= 2){
                con.addError('Can not add more than contacts');
            }
        }
        
    }
    
    public static void avoideCreatingContact(List<Contact> contacts){
        Set<Id> accountIds = new Set<Id>();
        
        for(Contact contact : contacts){
            accountIds.add(contact.accountId);
        }
        
        List<Account> accounts = [SELECT Id,(SELECT ID FROM Contacts) FROM Account WHERE id =: accountIds];
        
        for(Account account : accounts){
            for(Contact contact : account.Contacts){
                if(account.Contacts.size() > 2){
                    contact.addError('Can Not add more than 2  Contacts on a account');
                }
            }
        }
    }
    
    public static void createAccount(List<contact> conList){
        List<Account> accList = new List<Account>();
        for(Contact con : conList){
            if(con.AccountId == null){
                Account ac = new Account();
                ac.Name = con.LastName;
                ac.Phone = con.Phone;
                accList.add(ac);
            }
        }
        insert accList;
    }
    
    public static void emailPhoneMandatory(List<contact> conList){
        for(Contact con : conList){
            if(con.Phone == null){
                con.adderror('Please fill phone fields');
            }
            if(con.Email == null){
                con.addError('Please fill Email Field');
            }
        }
    }
    // If an Contact is not linked with account then add an error 
    public static void checkAccountLinked(List<contact> conList){
        for(contact con : conList){
            if(con.AccountId == null){
                con.addError('Account is Mandatory');
            }
        }
    }
    // if a contact is already in the org then avoid to duplicate
    /*
    public static void avoideduplicate(List<contact> conList){
        
        String firstName = userInfo.getFirstName();
        String Lastname = userinfo.getLastName();
        for(Contact con : conList){
            integer cons = [SELECT count() FROM contact  where lastName =: con.LastName];
            if(cons > 0){
               con.adderror('Find duplicate contact');
            }
        }
    }*/
    
   // Create Account after creating account and map it with the same contact
    public static void createContact(List<contact> conList){
      
        List<contact> cons = new List<contact>();
        for(Contact con : conList){
            if(con.AccountId == null){
                cons.add(con);
            }
            system.debug(cons);
        }
        List<Account> accList = new List<Account>();
        Map<string,contact> mapForAcc = new Map<String,contact>();
        for(contact con : cons){
            String accname = con.LastName + ' ' + con.FirstName;
            mapForAcc.put(accname, con);
            Account acc = new Account();
            acc.Name = accname;
            acc.Phone = con.Phone;
            accList.add(acc);
        }
        insert accList;
        for(Account acc : accList){
            if(mapForAcc.containskey(acc.Name)){
                mapforAcc.get(acc.Name).accountId = acc.Id;
            }
        }
    }
    
    public static void totalcontactunderaAccount(List<contact> conList){
        set<id> accId = new set<id>();
        for(contact cons : conList){
            accId.add(cons.accountId);
        }
        System.debug('contact Id -->' + accId);
        
        List<Account> accList = new List<Account>();
        List<AggregateResult> totalContact = [SELECT count(id)contacts, accountID accID FROM contact  WHERE accountId =:accId GROUP BY accountId];
        for(aggregateResult agr :totalContact){
            System.debug('contacts --> ' + agr.get('contacts'));
            
            Account acc = new Account();
            acc.id = (id)agr.get('accId');
            acc.total_contacts__c =(Integer)agr.get('contacts');
                accList.add(acc);
        }
        update accList;
    }

    
    public static void avoideDuplicate(List<contact> conList){
        List<string> conPhone = new List<String>();
        for(contact con : conList){
            conPhone.add(con.Phone);
        }
        // First method
       /*
        List<aggregateResult> exitCon = [SELECT count(id)cou FROM Contact WHERE Phone =: conPhone];
        for(aggregateResult con : exitcon){
            if((Integer)con.get('cou') > 0){
                for(Contact cons : conList){
            cons.addError('Find duplicate Phone');
        }
            }
        }
        */
        // Second Methos
        List<Contact> contacts = [SELECT id, Lastname, Phone FROm Contact WHERE phone =: conPhone];
            if(contacts.size() > 0){
                for(contact con : conList){
                    con.addError('Find duuplicate Phone');
                }
                
            }
    }
    
    public static void contactOtherPhone(List<contact> conList){
        set<id> accId = new set<Id>();
        for(contact con : conList){
            System.debug('Contact Id-->'+con.AccountId);
            accId.add(con.AccountId);
        }
        List<Account> accList = [SELECT Id,Phone FROM Account WHERE id =: accId];
        for(Account acc : accList){
            for(Contact con : conList){
                    con.AccountId = acc.Id;
                    System.debug('Contact Id-->'+con.AccountId);
                    con.OtherPhone = acc.Phone;
                    System.debug('Account Phone-->'+acc.Phone);
            }
        
    }
}
    // When a new contact is created add account phone in new contact other phone field
    public static void addOtherPhoneField(List<contact> conList){
        set<id> accId = new set<id>();
        
        for(contact con : conList){
            if(con.accountid != null){
                accId.add(con.accountId);
            }
            
        }
        List<Account> accounts = [SELECT Id,Name,phone FROM Account WHERE Id =: accId];
        map<Id,Account> accMap = new map<id,Account>();
        for(Account acc : accounts){
            accmap.put(acc.Id,acc);
        }
        for(contact con : conList){
            if(accmap.containsKey(con.AccountId)){
                con.OtherPhone = accmap.get(con.AccountId).phone;
            }
        }
    }
    
    // After insert trigger for count of contacts rollup on account but this method id not working while updating and delete
    public static void countContacts(List<contact> conList){
        set<id> accid = new set<id>();
        for(contact con : conList){
            accid.add(con.AccountId);
        }
        List<Account> accList = [SELECT id,Name,total_contacts__c,(SELECT Id,lastName FROM contacts) FROM Account WHERE id =: accid];
        for(account acc : accList){
            acc.total_contacts__c = 0;
            for(contact con : acc.contacts){
                acc.total_contacts__c +=1;
            }
        }
        update accList;
    }
    // Duplicate check on exisiting contact if Phone number is already present.
    public static void checkDuplicat(List<contact> conList){
        List<String> duplicatePhone = new List<String>();
        for(contact con : conList){
            duplicatePhone.add(con.Phone);
        }
        map<String,contact> conMap = new map<String,contact>();
        List<contact> contacts = [SELECT ID,LastName,Phone FROM contact WHERE phone =: duplicatePhone];
        for(contact con : contacts){
            conMap.put(con.Phone,con);
        }
        for(contact con : conList){
            if(conMap.containskey(con.Phone)){
                con.addError('Phone Number already exist');
            }
        }
    }
    public static void updateAccountDescription(Map<Id,Contact> newContactMap,List<Contact> oldContact){
            Set<Id> updateAccountsIds = new Set<Id>();
        for(Contact con : oldContact){
            if(con.Description != newContactMap.get(con.Id).Description){
                updateAccountsIds.add(con.AccountId);
            }
        }
        Map<Id,Account> relatedContactWithAccount = new Map<Id,Account>([SELECT Id,Description FROM Account WHERE id =: updateAccountsIds]);
        List<Account> updatesAccount = new List<Account>();
        for(Contact contact : newContactMap.values()){
            Account acc = relatedContactWithAccount.get(contact.AccountId);
            acc.description = contact.Description;
            updatesAccount.add(acc);
        }
        update updatesAccount;
        }
    
    public static void CountTotalContacts(List<Contact> contacts){
        Set<Id> accountsIds = new Set<Id>();
        for(Contact contact : contacts){
            accountsIds.add(contact.AccountId);
        }
        
    }
}