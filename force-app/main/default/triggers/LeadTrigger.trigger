trigger LeadTrigger on Lead (before update,after update) {

   system.debug('trigger'); 
        
    if(Trigger.isBefore){
        if(Trigger.isUpdate){

        }
    }
    else{
        if(Trigger.isUpdate){
            LeadTriggerHandler.updateMarketoLeads(Trigger.new,Trigger.old);
        }

}

}