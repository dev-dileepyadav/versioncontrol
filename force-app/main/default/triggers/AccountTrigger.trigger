trigger AccountTrigger on Account (after insert,after update) {

    if(Trigger.isAfter){
        if(Trigger.isInsert && !System.isBatch() && !System.isFuture() && !System.isQueueable()){

            Account acc = Trigger.new.get(0);

            if(acc.SyncWithS3__c == true && String.isBlank(acc.S3BucketName__c)){
                AccountTriggerHandler.createBuckets(Trigger.new);
            }
            
        }

        if(Trigger.isUpdate && !System.isBatch() && !System.isFuture() && !System.isQueueable()){
            Account acc = Trigger.new.get(0);
            Account oldRecord = Trigger.oldMap.get(acc.Id);
            if(acc.SyncWithS3__c != oldRecord.SyncWithS3__c && acc.SyncWithS3__c == true && String.isBlank(acc.S3BucketName__c)){
                AccountTriggerHandler.createBuckets(Trigger.new);
            }
        }
    }
}