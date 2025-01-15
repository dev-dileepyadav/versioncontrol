@isTest
public class WrapperClassTest {

    @isTest
    public static void getAccountNameTest(){
        List<Account> accounts = new List<Account>();
        for(Integer i = 0; i<5;i++){
            Account account = new Account();
            account.Name = 'Test '+i;
            account.Rating = 'Hot';
            accounts.add(account);
        }
        insert accounts;
        
         List<String> accountNames = new List<String>();
    
    for(Integer i = 0; i < 5; i++){
        accountNames.add('Test '+i);
    }
    Test.startTest();
    List<WrapperClass.AccountWrapper> result = WrapperClass.getAccountName(accountNames); 
    Test.stopTest();
        
        System.assertEquals(5,result.size());
        
        for(Integer i = 0; i<result.size();i++){
            WrapperClass.AccountWrapper wrapAccount = result[i];
            Account excepetedAccount = accounts[i];
            System.assertEquals(excepetedAccount.id,wrapAccount.accountid);
            System.assertEquals(excepetedAccount.Name,wrapAccount.accountName);
        }
    }
    
}