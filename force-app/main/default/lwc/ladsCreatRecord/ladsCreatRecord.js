import { LightningElement,api,track, wire } from 'lwc';
import { createRecord, getRecord } from 'lightning/uiRecordApi';

const fieldArray = ['Account.Name', 'Account.Phone','Account.Industry'];
export default class LadsCreatRecord extends LightningElement {

    name;
    phone;
    industry;

    get accRecName(){
        if(this.accountRecord.data){
            console.log(this.accountRecord);
            return this.accountRecord.data.fields.Name.value;
        }return '';
    }

    get accRecPhone(){
        if(this.accountRecord.data){
            return this.accountRecord.data.fields.Phone.value;
        }return '';
    }

    get accRecIndustry(){
        if(this.accountRecord.data){
            return this.accountRecord.data.fields.Industry.value;
        }return '';
    }
    @api
    recordId;

    @wire(getRecord, { recordId: '$recordId', fields: fieldArray })
    accountRecord;
    
    accName(event){
        this.name = event.target.value;
    }

    accPhone(event){
        this.phone = event.target.value;
    }

    accInducsty(event){
        this.industry = event.target.value;
    }

    handelclick(){

        const fie = {
            "Name":this.name,
            "Phone":this.phone,
            "Industry":this.industry
        };

        const recordDetails = {
            apiName:"Account",
            fields:fields
        }
        createRecord(recordDetails).then(x=>{
            //console.log('Created record' +JSON.stringify(x));
        }).catch(err =>{
            //console.log(JSON.stringify(err));
        })
    }
}