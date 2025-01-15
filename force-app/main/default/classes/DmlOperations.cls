public class DmlOperations {
    
    public static void createAccount(String name,String description){
        List<Account> accList = new List<Account>();
        Account acc = new Account();
        acc.name = name;
        acc.Description = description;
        accList.add(acc);
        insert accList;
    }

    
    public static void updateAccounts(){
        List<Account> accList = [SELECT Id,Name,phone FROM Account];
        for(Account ac : accList){
            if(ac.phone == null){
                ac.phone = '123456';
            }
        }
    }
    
    public static void deleteOperations(){
            List<Account> accList = [SELECT id,Name,Phone FROm Account WHERE Phone = null];
            
           delete accList;
        }
}