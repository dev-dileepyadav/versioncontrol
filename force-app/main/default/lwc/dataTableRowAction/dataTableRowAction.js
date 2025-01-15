import { LightningElement,wire } from 'lwc';
import getContactsForCustomDataTable from '@salesforce/apex/ContactController.getContactsForCustomDataTable';

    const columns = [
        { label: 'Name', fieldName: 'Name',editable: true},
        { label: 'Title', fieldName: 'Title',editable: true},
        { label: 'Phone', fieldName: 'Phone', type: 'phone' ,editable: true},
        { label: 'Email', fieldName: 'Email', type: 'email' ,editable: true}
    ];
    const actions = [{label:'View',name:'view'},
    {label:'Edit',name:'edit'},
    {label:'Delete',view:'delete'}]

export default class DataTableRowAction extends LightningElement {

    columns = columns;
    data;
    error;

    @wire(getContactsForCustomDataTable)
    wiredContacts({data,error}){
        if(data){
            this.data = data;
            this.error = null;
        }else if(error){
            this.error = error;
            this.data = null;
        }
    }

    handleRowAction(event){

    }
}