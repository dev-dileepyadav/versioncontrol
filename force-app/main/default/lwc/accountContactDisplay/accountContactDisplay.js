import { LightningElement, api, wire } from 'lwc';
import getAllAccountWithContacts from '@salesforce/apex/AccountContactWrapper.getAllAccountWithContacts';
export default class AccountContactDisplay extends LightningElement {
    @api accountsWithContact;
    @api error;

    @wire(getAllAccountWithContacts)
    wiredAccountsWithContacts({error, data}){
        if(data){
            this.accountsWithContact = data;
        }else if(error){
            console.log(error);
            this.error.error;
        }
    }

}