public with sharing class AccountTriggerHandler {
   
    public static void createBuckets(List<Account> newAccount){

        for(Account acc : newAccount){
            createBucket(acc.Name,acc.Id,'');
        }

    }

    @future(callout = true)
    public static void createBucket(String bucketName, String recordId, String region){

        AWSS3Manager.createBucket(bucketName,recordId,region);

    }
}