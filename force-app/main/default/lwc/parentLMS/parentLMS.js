import { LightningElement, wire } from 'lwc';
import { publish, messageContext } from 'lightning/messageService';
import COMPONRNT_COMMUNICATION_CHANNEL from '@salesforce/messageChannel/ComponentCommunication__c';

export default class ParentLMS extends LightningElement {

    @wire(messageContext)
    messageContext;

    inputText = '';

    handleChnage(e){
        this.inputText = e.target.value;
    }
    handleButtonClick(){
        //const messageInput = this.template.querySelector('lightning-input').value;
        const payload = {message : this.inputText};
        publish(this.messageContext,COMPONRNT_COMMUNICATION_CHANNEL,payload);
    }

}

