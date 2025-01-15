import { LightningElement, api } from 'lwc';
//import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class EeAlert extends LightningElement {
    errorMessage = '';
    successMessage = '';

    @api
    show() {
        if(this.successMessage){
            this.successMessage = 'success';
        }else {
            this.errorMessage = 'Error';
        }
        /*
        //if(this.isSuccess){
            const event = new ShowToastEvent({
                title: 'title',
                message: 'message',
                variant:'Error'
            });
            this.dispatchEvent(event);
        //}
        /*else {
            const event = new ShowToastEvent({
                title: title,
                message: message,
                    variant: variant
            });
            this.dispatchEvent(event);
        }*/
    }
/*
    showing(){
        this.show('Title','Message','error');
    }*/
}