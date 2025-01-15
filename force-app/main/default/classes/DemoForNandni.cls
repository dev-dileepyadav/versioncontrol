public class DemoForNandni implements database.batchable <sobject>{
// Call Batchable class
// ContactsBatchable be = new ContactsBatchable();
//database.executeBatch(be,1); here 1 is record size per batch
    public database.queryLocator start(database.batchableContext bc){
        return database.getqueryLocator('SELECT id,Name FROM Account');
    }
    
    public void execute(database.batchableContext bc, List<Account> accList){
        for(Account acc  :accList){
            System.debug(acc);
        }
    }
    
    public void finish(database.batchableContext bc){
    }
   
}