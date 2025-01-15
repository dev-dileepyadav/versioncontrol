@isTest
public class TestMathOperations {

    @isTest
    public static void testAdd(){
        Integer a = MathOperations.add(5,3);
        
        System.assertEquals(8,a);
    }
    
    @isTest
    public static void testMinius(){
        Integer b = MathOperations.minius(5, 3);
        system.assertEquals(2,b);
    }
}