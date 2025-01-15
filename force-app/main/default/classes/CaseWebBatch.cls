public with sharing class CaseWebBatch implements Database.Batchable<sObject>{
    public List<Id> caseId = new List<Id>();

    public CaseWebBatch(List<Id> caseId) {
        this.caseId = caseId;
    }

    public Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'SELECT Id,Origin,CaseNumber FROM Case WHERE Id NOT IN : caseId';
       
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext BC, List<Case> scope)
    {
        for(Case a : scope)
        {
            System.debug('Origin web -->'+a.Origin);
        }
    }
    public void finish(Database.BatchableContext BC) {


    }
}