public with sharing class TestDataFactory {

    public static List<Case> createCase(Integer numberOfCase){
        List<Case> newCases = new List<Case>();
        for(Integer i = 0; i<= numberOfCase; i++){
            Case cs = new Case(Subject='Excellent Subject');
            newCases.add(cs);
        }
        return newCases;
    }
}