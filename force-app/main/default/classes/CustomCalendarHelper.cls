public with sharing class CustomCalendarHelper {
    
    @AuraEnabled
    public static List<sObject> getEvents(
        String recordId,
        String childObject,
        String parentFieldName,
        String startDatetimeField,
        String endDatetimeField,
        String titleField,
        Date startDate,
        Date endDate) {

        if (
            recordId == null ||
            childObject == null ||
            parentFieldName == null ||
            startDatetimeField == null ||
            endDatetimeField == null ||
            titleField == null
        ) {
            throw new AuraHandledException('Missing Config');
        }

        DateTime startDateTime = DateTime.newInstance(startDate.year(), startDate.month(), startDate.day());
        DateTime endDateTime = DateTime.newInstance(endDate.year(), endDate.month(), endDate.day());

        String query = 'SELECT Id, ' + titleField + ', ';
        // query = childObject== 'Event' ? query : query + 'Name, ';
        query += startDatetimeField + ', ' + endDatetimeField;
        query += ' FROM ' +  childObject;
        query += ' WHERE ' + parentFieldName + ' = ' + '\'' + recordId +'\'';
        query += ' AND ' + startDatetimeField + ' >= : startDateTime';
        query += ' AND ' + endDatetimeField + ' <=  : endDateTime';
        system.debug(query);
        return Database.query(query);
    }

    @AuraEnabled(cacheable=true)
    public static List<User> getPicklistOptions() {
        return [SELECT Id, Name FROM User];
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> searchAccountNameMethod (String accStrName, String accStrPhone, String accStrWebsite, String accStrIndustry, String accStrDescription){
        String keyNameString = '%' +  accStrName + '%';
        return [Select Id, Name, Phone, Website, Industry, Description From Account Where Name like:keyNameString];
     }
}