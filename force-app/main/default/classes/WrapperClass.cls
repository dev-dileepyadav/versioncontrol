public class WrapperClass {
    
    public static List<AccountWrapper> getAccountName(List<String> accountName){
        
        List<AccountWrapper> resultRecords = new List<AccountWrapper>();
        String query = 'SELECT id,Name FROM Account WHERE Name IN : accountNAme AND rating != null';
        List<Sobject> queryResult = Database.query(query);
        
        for(Sobject account : queryResult){
            AccountWrapper accountWraper = new AccountWrapper();
            accountWraper.accountId = (String)account.get('Id');
            accountWraper.accountName = (String)account.get('Name');
            resultRecords.add(accountWraper);
        }
        return resultRecords;
    }

    
    public class AccountWrapper{
        public String accountId;
        public String accountName;
    }
}