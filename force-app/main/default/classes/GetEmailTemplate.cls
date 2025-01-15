public with sharing class GetEmailTemplate {
   
    @AuraEnabled(cacheable=true)
    public static List<EmailTemplate> getEmailTemplate(){
        return [SELECT Id, Name, DeveloperName, Body FROM EmailTemplate];
    }
    
}