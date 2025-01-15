public with sharing class LocationHandler {
   
    @AuraEnabled(cacheable=true)
    public static List<Location__c> GetLocationData(Date searchDate){
        List<Location__c> location = [SELECT Id, Name, End_Location__Latitude__s, End_Location__Longitude__s, Start_Location__Longitude__s, Start_Location__Latitude__s,Work_Date_And_Time__c,Work_Date__c,Location_Title__c  FROM Location__c WHERE Work_Date__c =: searchDate ORDER BY Work_Date_And_Time__c DESC];

        return location;
    }
}