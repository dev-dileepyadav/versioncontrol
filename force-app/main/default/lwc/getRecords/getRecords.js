import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
/*
const colums = [
    {lable:'Name',fieldName:'Name'},
    {lable:'Phone',fieldName:'Phone', type:'phone'}
]*/

const colums = ['Account.Name','Account.Phone'];
export default class GetRecords extends LightningElement {

    @api
    recordId;

    data = [];
    columns = colums


    @wire(getRecord,{recordId: '$recoredID',fields: colums}) accRecord;

    connectedCallback(){
        this.data = this.accRecord.data;
    }
}