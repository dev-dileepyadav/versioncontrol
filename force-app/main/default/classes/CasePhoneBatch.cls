public class CasePhoneBatch implements Database.Batchable<sObject>, Database.Stateful{
    public List<Id> caseIds = new List<Id>();
    public Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'SELECT Id,Origin FROM Case WHERE Origin = \'Phone\'';
       
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext BC, List<Case> scope)
    {
        for(Case a : scope){
            caseIds.add(a.Id);
            System.debug('Origin Phone -->'+a.Origin);
        }
    }
    public void finish(Database.BatchableContext BC) {
        CaseWebBatch casebat = new CaseWebBatch(caseIds);
        Id batchJobId = Database.executeBatch(casebat, 2);

    }
    
}