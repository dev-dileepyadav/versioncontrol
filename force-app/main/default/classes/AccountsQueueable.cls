public class AccountsQueueable implements queueable {
    public void execute(System.queueableContext bx){
        
        Id jobId = bx.getJobId();
        List<asyncapexjob> jobStatus = [SELECT id,status FROM asyncapexjob WHERE id =: jobId];
    }
}


/*AccountsQueueable q = new AccountsQueueable();
Integr SystemDely = 10
Id jobId = system.enqueueJOb(q,SystemDely);

System.debug(jobId);

*/