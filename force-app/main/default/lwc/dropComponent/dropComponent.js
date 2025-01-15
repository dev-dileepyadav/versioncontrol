import { LightningElement,track } from 'lwc';

import NAME_FIELD from '@salesforce/schema/Account.Name';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import TYPE_FIELD from '@salesforce/schema/Account.Type';

export default class DropComponent extends LightningElement {

    fields = [NAME_FIELD,TYPE_FIELD,INDUSTRY_FIELD];

    @track accountId;
    @track message = 'Drop an account here';

    dropElement(e){
        this.accountId = e.dataTransfer.getData("account_id");
        console.log('Account Id',this.accountId);
        this.message = '';
    }

    allowDrop(e){
        e.preventDefault();
    }
}