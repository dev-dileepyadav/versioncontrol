public class Batchable implements database.batchable<sObject>{
    public dataBase.queryLocator start(dataBase.batchableContext bc){
        String query = 'SELECT Id,name,type,description FROM Account';
        return database.getqueryLocator(query);
    }
    
    public void execute(database.batchableContext bc, List<Account> accList){
        
        for(Account acc : accList){
            String type = acc.type != null ? acc.type : 'unkown';
            acc.description = 'updated by batch job by  :'+type;
        }
        update accList;
        
        
    }
    public void finish(database.batchableContext bc){
        
    }
    

}