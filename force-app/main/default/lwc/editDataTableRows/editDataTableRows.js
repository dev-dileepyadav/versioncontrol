import { LightningElement, wire } from 'lwc';
import getContactsForCustomDataTable from '@salesforce/apex/ContactController.getContactsForCustomDataTable';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import {refreshApex} from "@salesforce/apex";


const columns = [
    { label: 'Name', fieldName: 'Name',editable: true},
    { label: 'Title', fieldName: 'Title',editable: true},
    { label: 'Phone', fieldName: 'Phone', type: 'phone' ,editable: true},
    { label: 'Email', fieldName: 'Email', type: 'email' ,editable: true}
];

export default class EditDataTableRows extends LightningElement {

    columns = columns;

    draftValues = [];
    contacts = [];
    error;
    contactRefreshProperty;

    @wire(getContactsForCustomDataTable)
    wiredContacts(result){
        this.contactRefreshProperty = result;
        if(result.data){
            this.contacts = result.data;
            this.error = null;
            console.log('Data -->',result.data);
        }else if(result.error){
            this.error = result.error;
            this.contacts = null;
        }
    }

    draftValues(event){

    }

    async saveHandler(event){

        let records = event.detail.draftValues; // it will return array of modified records
        console.log('Records -->',records);
        let updateRecordsArray = records.map(item =>{
            let fieldInput = {...item};
            return {
                fields : fieldInput
            };
        });
        this.draftValues = [];
        let updateRecordsArrayPromise = updateRecordsArray.map((currItem) =>
            updateRecord(currItem)
        );

        await Promise.all(updateRecordsArrayPromise);
        const toastEvent = new ShowToastEvent({
            title: 'Saved',
            message: 'Recordes saved',
            variant:'success'
        });
        this.dispatchEvent(toastEvent);
        await refreshApex(this.contactRefreshProperty);
    }

    moveScreen(){
        document.scrollBy(0, -50)
    }

    handleUpClick(){
       //this.template.querySelector(".lightning-datatable").addEventListener("click",moveScreen());
       //document.addEventListener("click", function(){
        //this.template.
        //document.querySelector("lightning-datatable").window.scrollBy(0, -50)
        this.template.querySelector("lightning-datatable").scrollBy(0, -50);
        //addEventListener("click",moveScreen());
      //}
      //);
        //window.scrollBy(0, -50);
        //window
    };

    handleDownClick(){
        
            this.template.querySelector("lightning-datatable").scrollBy(0, -50);
          
    };

    
    
    }