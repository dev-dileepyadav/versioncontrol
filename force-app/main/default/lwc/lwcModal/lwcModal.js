import { LightningElement,track } from 'lwc';

export default class LwcModal extends LightningElement {

    showInput = false;

    handleShow(){

        if(!this.showInput){
            this.showInput = true;
        }else{
            this.showInput = false;
        }
        
    }
    inputValue = 'This value is comming from backend';
}