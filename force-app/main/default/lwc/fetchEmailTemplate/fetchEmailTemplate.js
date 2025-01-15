import { LightningElement, wire } from 'lwc';
import { getPicklistValues } from "lightning/uiObjectInfoApi";
import templateType from '@salesforce/schema/EmailTemplate.TemplateType';
import getEmailTemplate from '@salesforce/apex/GetEmailTemplate.getEmailTemplate';

export default class FetchEmailTemplate extends LightningElement {

    data;
    error;
    /*
    @wire(getPicklistValues, { recordTypeId: "012000000000000AAA", fieldApiName: templateType })
    emailTemplateType({error,data}){
        if(data){
            console.log(data);
        this.data = data;
        }else if(error){
            this.error = error;
            console.log(error);
        }
    }
    */
   @wire(getEmailTemplate)wiredTemplate({data,error}){
    if(data){
        console.log(data);
    this.data = data;
    }else if(error){
        this.error = error;
        console.log(error);
    }
   }
}