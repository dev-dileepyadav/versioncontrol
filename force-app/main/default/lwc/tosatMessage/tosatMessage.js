import { LightningElement } from 'lwc';

export default class TosatMessage extends LightningElement {

    displayToast(){
        this.template.querySelector('c-ee-alert').show();
    }
}