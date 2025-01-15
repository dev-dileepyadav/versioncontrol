@isTest
public class TaskTestclass {

    @isTest
    public static void getTaskPriortyTestCA(){
        String taskPriorityCA = TaskTest.getTaskPriorty('CA');
        System.assertEquals('High',taskPriorityCA);
    }
    
    @isTest
    public static void getTaskPriortyTestOther(){
        String taskPriorityOther = TaskTest.getTaskPriorty('CB');
        System.assertEquals('Normal',taskPriorityOther);
    }
    
    @isTest
    public static void getTaskPriortyTestNull(){
        String taskPriorityNormal = TaskTest.getTaskPriorty('CBKJFDKJ');
        System.assertEquals(null,taskPriorityNormal);
    }
}