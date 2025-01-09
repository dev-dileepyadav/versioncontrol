import { LightningElement, wire } from 'lwc';
import { getPicklistValues,getObjectInfo } from 'lightning/uiObjectInfoApi';
import Account from '@salesforce/schema/Account';
import AccountSource from '@salesforce/schema/Account.AccountSource';

export default class AccountPickListValue extends LightningElement {

    recordTypeId;
    accountSource;
    selectedValue;
    @wire(getObjectInfo, { objectApiName: Account })
    objectInfo({error, data}) {
        if(data) {
            this.recordTypeId = data.defaultRecordTypeId;
        }else if(error){
            console.log(error);
            
        }
    }

    @wire(getPicklistValues,{recordTypeId:'012dM000003RpSvQAK',fieldApiName:AccountSource}) 
    options({error,data}) {
       if(data){
        this.accountSource = data.values;
       } else if(error){
        console.log('Error',error);
       }
        
    }

    handleChange(event){
        console.log('Event',event.target);
        this.selectedValue = event.detail.value;
        
    }
}