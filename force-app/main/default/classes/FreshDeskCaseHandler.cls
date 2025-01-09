public with sharing class FreshDeskCaseHandler {
    
    public static void handleCase(List<Case> newCase){
        Set<Id> CaseIds = new Set<Id>();

        for(Case cs : newCase){
            CaseIds.add(cs.Id);
        }

        FreshDeskCaseHandler.createFeshDeskCase(CaseIds);
    }
    





    @future(callout=true)
    public static void createFeshDeskCase(Set<Id> caseId){

        List<Case> cases = [SELECT id,CaseNumber,Description,Subject,SuppliedEmail FROM Case Where Id IN: caseId];

        for(Case cs : cases){
            FreshWorksCallOut.getPost(String.valueOf(cs.CaseNumber),cs.Description,cs.Subject,cs.SuppliedEmail);
        }

    }

}