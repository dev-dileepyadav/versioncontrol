trigger CaseTrigger on Case (after insert) {

    if(Trigger.isAfter && Trigger.isInsert){
        FreshDeskCaseHandler.handleCase(Trigger.new);
    }
}