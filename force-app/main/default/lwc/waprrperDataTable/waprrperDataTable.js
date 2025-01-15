import { LightningElement,wire } from 'lwc';
import wrapperContacts from '@salesforce/apex/ContactController.wrapperContacts';
import { deleteRecord } from 'lightning/uiRecordApi';
const columns = [
    { label: 'Title', fieldName: 'Title' },
    { label: 'First NAme', fieldName: 'FirstName' },
    { label: 'Last Name', fieldName: 'LastName'},
    { label: 'Phone', fieldName: 'phone', type: 'phone' },
    { label: 'Email', fieldName: 'Email', type: 'email' },
    { label: 'Case Count', fieldName: 'caseCount'},
    { label: 'Is Bad Contact', fieldName: 'isBadContact',type:'boolean'},
    { label: 'Account', fieldName: 'accountName'},
];
export default class WaprrperDataTable extends LightningElement {
    columns = columns;
data;
error
isButtonDisabled = true;
    @wire(wrapperContacts)
    wiredContacts({error,data}){
        if(data){
            this.data = data;
            this.error = null;
            console.log(data);
        }else if(error){
            this.error = error;
            this.data = null;
            console.log(error);
        }
    }


    async deleteMultipleRecords(){
        let selectedRecords = this.template.querySelector('lightning-datatable').getSelectedRows();
        let allGoodRecords = true;
        let selectedRecordsHaveCase = selectedRecords.filter((currentItem)=>currentItem.caseCount > 0);

        if(selectedRecordsHaveCase.length > 0){
            allGoodRecords = false;
        }
        if(allGoodRecords){
            // Delete records
            let deleteRecordsConfirmation = selectedRecords.map((currentItem) => deleteRecord(currentItem.Id));
            try{
                await Promise.all(deleteRecordsConfirmation);
                this.template.querySelector('lightning-datatable').getSelectedRows = [];
            }catch(error){

            }
        }else {
            //Show error
        }
    }

    handleRowSelection(event){
        const selectedRows = event.detail.selectedRows;
        if(selectedRows.length > 0){
            this.isButtonDisabled = false;
        }else{
            this.isButtonDisabled = true;
        }
    }
}