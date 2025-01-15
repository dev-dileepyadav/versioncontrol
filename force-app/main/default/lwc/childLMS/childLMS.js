import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import COMPONRNT_COMMUNICATION_CHANNEL from '@salesforce/messageChannel/ComponentCommunication__c';

export default class ChildLMS extends LightningElement {

    @wire(MessageContext)
    messageContext;

    subscription = null;

    recivedMessage = 'No Message recived yet';

    subscribeToMEssageChannesl(){
        if(!this.subscription){
            this.subscription = subscribe(this.messageContext, COMPONRNT_COMMUNICATION_CHANNEL, (message) => {
                this.handleMessage(message);
            });
        }
    }

    connectedCallback(){
        this.subscribeToMEssageChannesl()
    }

    handleMessage(payload){
        this.recivedMessage = payload.message;
    }

}