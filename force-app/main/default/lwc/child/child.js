import { LightningElement, api } from 'lwc';

export default class Child extends LightningElement {
    firstName;
    lastName;
    @api 
    getDataFromParent(name){
        console.log('Name-->', name);
        this.firstName = name.firstNames;
        this.lastName = name.lastNames;
    }
}