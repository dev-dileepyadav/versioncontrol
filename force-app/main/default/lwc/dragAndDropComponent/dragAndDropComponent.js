import { LightningElement, wire } from 'lwc';
import getAccountData from '@salesforce/apex/AccountHelper.getAccountData';
export default class DragAndDropComponent extends LightningElement {

    data;
    error;

    @wire(getAccountData)
    wiredAccounts({error,data}){
        if(data){
            this.data = data;
            this.error = null;
        }else if(error){
            this.error = error;
            this.data = null;
        }
    }

    handleDragStart(e){
        e.dataTransfer.setData("account_id",e.target.dataset.item);
    }
}