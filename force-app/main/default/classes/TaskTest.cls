public class TaskTest {

    public static String getTaskPriorty(String leadState){
        if(String.isBlank(leadState) || leadState.length() > 2){
            return null;
        } 
        String taskPriority;
        if(leadState == 'CA'){
            taskPriority = 'High';
        }else{
            taskPriority = 'Normal';
        }
        return taskPriority;
    }
}