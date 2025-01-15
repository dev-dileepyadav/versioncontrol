public class BatchableApex implements Database.Batchable<sObject> {
    
    public database.queryLocator start(database.batchableContext bc){
        return database.getQueryLocator('SELECT Id,Name FROM Account LIMIT 1');
    }
    
    public void execute(DataBase.batchableContext bc, List<Account> accounts){
        
    }
    
    public void finish(DataBase.batchableContext bc){
        
    }
}

/*
 BatchableApex batch = new BatchableApex();

Id jobId = database.executeBatch(batch);
Integer batchSize = 100;
id = jobId = database.executeBatch(batch,batchSize)

System.debug(jobId); 
 
 */