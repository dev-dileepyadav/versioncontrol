import { LightningElement, wire } from 'lwc';
import getAccountData from '@salesforce/apex/AccountHelper.getAccountData';
import deleteAccount from '@salesforce/apex/AccountHelper.deleteRecords';
import { refreshApex } from "@salesforce/apex";

const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Industry', fieldName: 'Industry'},
    { label: 'Phone', fieldName: 'phone', type: 'phone' }
];

export default class DeleteMultipleRecords extends LightningElement {

    columns = columns
    selectedRecords = [];
    @wire(getAccountData) accounts;

    getSelectedRecords(e){
        console.log('Record Id-->',e.detail.config.value);
        const selectedRecords = e.detail.selectedRows;
        for(let i = 0; i< selectedRecords.length;i++){
            this.selectedRecords.push(selectedRecords[i].Id);
        }
    }

    handleClick(){
        deleteAccount({accIds: this.selectedRecords}).then(()=>{
            this.template.querySelector('lightning-datatable').selectedRows = [];
            refreshApex(this.accounts);
        }).catch((error)=>{
            console.log('Error -->',error);
        })
    }
}