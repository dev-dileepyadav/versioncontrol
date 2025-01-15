@isTest
public with sharing class DemoTest {
   
    @TestSetup
    static void makeData(){
        List<Case> cases = TestDataFactory.createCase(3);
        insert cases;
    }


    @isTest
    public static void multiply_positive(){
        Test.StartTest();
        Integer result = Demo.multiply(7,2);
        Test.StopTest();
        Assert.areEqual(14,result,'Results are not Matched');
    }

    @isTest
    public static void updateCase(){
        List<Case> cases = [SELECT id,subject FROM Case WHERE Subject = 'Excellent Subject'];
        Test.startTest();
        Demo.updateTest(cases[0]);
        Test.StopTest();
    }

}