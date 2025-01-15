import { LightningElement, wire } from 'lwc';
import getAccountData from '@salesforce/apex/AccountHelper.getAccountData';
import { deleteRecord } from 'lightning/uiRecordApi';
import { refreshApex } from "@salesforce/apex";
export default class DeleteOneRecord extends LightningElement {

    @wire(getAccountData)accounts;

    accountId
    handleChange(e){
        this.accountId = e.target.value;
        console.log('Account Id-->', e.target.value);
    }

    handleClick(){
        deleteRecord(this.accountId).then(() => {refreshApex(this.accounts)}).catch((error)=>{
            console.log('Error-->',error);
        })
    }


}