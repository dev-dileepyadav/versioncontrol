public with sharing class AccountHelper {
   @AuraEnabled(cacheable=true)
   public static List<Account> getAccountData(){
    return [SELECT Id,Name,Industry,Phone FROM Account ORDER BY CreatedDate DESC];
   }

   @AuraEnabled
   public static List<Account> deleteRecords(List<Id> accIds){
      List<Account> recordsToBedelte = new List<Account>();
      for(Account account : [SELECT Id FROM Account WHERE Id In : accIds]){
         recordsToBedelte.add(account);
      }

      delete recordsToBedelte;
      return getAccountData();
   }
}