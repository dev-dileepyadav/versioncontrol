public with sharing class CustomMetaDataPractice {
   
    @AuraEnabled(cacheable = true)
    public static List<practice_meta_data__mdt> getPracticeMetaData(){
        List<practice_meta_data__mdt> practiceMetadata = [SELECT email__c, Id, DeveloperName, MasterLabel, Label FROM practice_meta_data__mdt];

        return practiceMetadata;
    }

    public static void updateCustomMetaData(){

        List<practice_meta_data__mdt> practiceMetadata = [SELECT email__c, Id, DeveloperName, MasterLabel, Label FROM practice_meta_data__mdt];

        Metadata.customMetadata meta = new Metadata.customMetadata();
        meta.fullName = 'practice_meta_data__mdt.email__'+practiceMetadata[0].DeveloperName;
    }
}