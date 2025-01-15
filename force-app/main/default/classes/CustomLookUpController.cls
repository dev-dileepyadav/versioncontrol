public with sharing class CustomLookUpController {
    @AuraEnabled(cacheable=true)
    public static List<sObject> searchRecords(String searchKey, String objectApiName){
        List<sObject> record = new List<sObject>();
            String key = '%'+searchKey+'%';
            if(String.isNotBlank(key)){
                String queryString = 'SELECT Id,Name FROM '+objectApiName+' WHERE Name Like:key order by Name';
            record = Database.query(queryString);
        return record;
            }
            return record;
    }
}