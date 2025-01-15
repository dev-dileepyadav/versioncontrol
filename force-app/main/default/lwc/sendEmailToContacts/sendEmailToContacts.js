import { LightningElement, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContactsForCustomDataTable';
import sendEmail from '@salesforce/apex/ContactController.SendEmail';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Phone', fieldName: 'phone', type: 'phone' },
    { label: 'Email', fieldName: 'Email', type: 'email' }
];

export default class SendEmailToContacts extends LightningElement {

    columns = columns;
    @wire(getContacts) contacts;

    selectedContacts = [];

    getSelectedRecords(e){
        const selectedRecords = e.detail.selectedRows;

        for(let i = 0; i< selectedRecords.length;i++){
            this.selectedContacts.push(selectedRecords[i].Id);
        }
    }

    handleClick(){
        sendEmail({contactIds:this.selectedContacts}).then(()=>{
            this.template.querySelector('lightning-datatable').selectedRows = [];
                const event = new ShowToastEvent({
                    variant:'success',
                    title: 'Sent',
                    message:'Email sent sucefully.',
                });
                this.dispatchEvent(event);

            console.log('email send');
        }).catch((error)=>{
            const event = new ShowToastEvent({
                variant:'error',
                title: 'Not send',
                message:'Your email can not sent sucefully.',
            });
            this.dispatchEvent(event);
            console.log(JSON.stringify(error));
        })
    }
}