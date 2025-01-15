import { LightningElement, wire } from 'lwc';
import getPracticeMetaData from '@salesforce/apex/CustomMetaDataPractice.getPracticeMetaData';

import customemail from '@salesforce/apex/CustomMetaDataPractice.isNotificationEnabled';
export default class CustomMetaDataPractice extends LightningElement {

    data;
    error;
    /*
    @wire(getPracticeMetaData)
    wiredMetaData({data,error}){
        if(data){
            this.data = data
            console.log('Data', data);
        }else if(error){
            console.log('error',error);
            this.error = error
        }
    }
*/
    handleChange(e){
        console.log(e.target.value);
    }

    @wire(customemail)
    wiredEmail({data,error}){
        if(data){
            this.data = data
            console.log('Data', data);
        }else if(error){
            console.log('error',error);
            this.error = error
        }
    }
}