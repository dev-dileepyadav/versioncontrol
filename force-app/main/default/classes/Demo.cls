public with sharing class Demo {
   
    public static Integer multiply(Integer a, Integer b){
        return a*b;
    }

    public static void updateTest(Case cas){
        cas.Subject = 'Hello Dileep';
        update cas;

    }
}