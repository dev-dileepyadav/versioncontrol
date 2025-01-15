import { LightningElement, wire } from 'lwc';
import getAccountData from '@salesforce/apex/AccountHelper.getAccountData';

const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Industry', fieldName: 'Industry'},
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Rating', fieldName: 'Rating'}
];
export default class Wiredecorator extends LightningElement {
    columns = columns;
   // @wire(getAccountData) accounts;
   accounts;
   error;

   @wire(getAccountData)
   accountFunction({data,error}){
    if(data){
        let updatedAccounts = data.map(currentItem =>{
            let updatedObject = {};
            if(!currentItem.hasOwnProperty('Rating')){
                updatedObject = {...currentItem,Rating:'Warm'}
            }else{
                updatedObject = {...currentItem};
            }
            return updatedObject;
        });
        this.accounts = [...updatedAccounts];
        this.error = null;
    }else if(error){
        this.error = error;
        this.accounts = null;
    }
   }
}