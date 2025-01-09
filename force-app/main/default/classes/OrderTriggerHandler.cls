public with sharing class OrderTriggerHandler {
    
    public static void createFolderInsideBucket(Order newOrder){
        List<Account> account = [SELECT Id ,SyncWithS3__c,S3BucketName__c FROM Account WHERE ID =: newOrder.accountId LIMIT 1];
        if(account?.size() > 0 && account.get(0).SyncWithS3__c && String.isNotBlank(account.get(0).S3BucketName__c)){
            createFolderInsideBucket(account.get(0).S3BucketName__c,'orders',newOrder.orderNumber.toLowerCase());

        }
    }

    @future (callout = true)
    public static void createFolderInsideBucket(String bucketPath,String folderPath, String folderName){
        AWSS3Manager.createBucketFolderInsideBucketFolder(bucketPath,folderPath,folderName);
    }
}