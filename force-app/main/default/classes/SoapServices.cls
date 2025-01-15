global with sharing class SoapServices {
    webservice static Account getRecord(String id){
        Account acc = [SELECT id,Name,Phone FROM Account WHERE id=:id];
        return acc;
    }

}