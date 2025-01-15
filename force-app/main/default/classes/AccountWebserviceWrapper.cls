global with sharing class AccountWebserviceWrapper {

    global class getAccounts{
        global List<String> accounts;
    }
    
    global class getAccountResponse{
        global String message;
        global boolean success;
        global List<Account> accountsList;
    }
    
    global class Accounts{
        global String name;
        global String phone;
        global String fax;
        
    }
    
    global class response{
        global String message;
        global boolean success;
    }
}