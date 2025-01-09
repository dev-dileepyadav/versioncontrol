trigger ZendeskCaseCreate on Case (after insert) {

    ZendeskCaseTriggerHandler.handleAfter(Trigger.new);
    
}