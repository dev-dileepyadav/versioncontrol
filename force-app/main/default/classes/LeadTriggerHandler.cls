public with sharing class LeadTriggerHandler {
    
        public static void updateMarketoLeads(List<Lead> leads, List<Lead> oldLeads){
            if(!checkRecursive.firstcall){
                Database.DMLOptions dmo = new Database.DMLOptions();
                dmo.AssignmentRuleHeader.useDefaultRule = true;
                System.debug('Executing');
                Set <Id> userIds = new Set<Id>();
                
                for(lead l: leads){
                    userIds.add(l.OwnerId);
                }
    
                List <Group> gList = [SELECT Id, Name FROM Group WHERE DeveloperName = 'Test_Lead_QUeue'];
                
                system.debug('glist = ' + gList);

                
                Set <Id> leadIdSet = new Set<Id>();
                
                for(lead l: leads){
                    if(l.Country != null && l.label__c != null && l.Status != 'Working' && l.Status != 'Unqualified' && l.MQL_Date__c != null && l.Inbound_Type__c != null && (l.Inbound_Type__c?.contains('MQL') || l.Inbound_Type__c == 'Pricing Request' || l.Inbound_Type__c == 'Contact Request')){
                        for(lead ol: oldLeads){
                            if(l.Id == ol.Id && (l.Inbound_Type__c != ol.Inbound_Type__c || l.MQL_Date__c != ol.MQL_Date__c)){   
                                system.debug('here 28');
                                for(group g: gList){
                                    if(g.Id == l.OwnerId){
                                        leadIdSet.add(l.Id);
                                    }
                                }
                            }
                        }
                    }
                }
                system.debug('id set = ' + leadIdSet);
                list <Lead> readyList = [SELECT Id, Assignment_retriggered__c FROM Lead WHERE Id IN :leadIdSet];
                for(integer i = 0; i < readyList.size(); i++){
                    readyList[i].Assignment_retriggered__c = System.now();
                }
                
                system.debug('readyList = ' + readyList);
                if(readyList.size() > 0){
                    Database.update(readyList,dmo);
                }
            }
        }
    }