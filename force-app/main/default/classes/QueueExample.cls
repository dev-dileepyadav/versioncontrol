public class QueueExample implements queueable {

    public static void execute(System.QueueableContext qc){
        system.debug('This is from first queue class');
        QueueExample2 q  = new QueueExample2();
        System.enqueueJob(q);
    }
}