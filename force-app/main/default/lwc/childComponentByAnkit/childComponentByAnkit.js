import { LightningElement, api } from 'lwc';

export default class ChildComponentByAnkit extends LightningElement {
    @api displaygreeting;
    @api areTrue = 'false';
    displayUser = "";

    set user(value){
        let use = {...value}
            this.displayUser = use.firstName.toUpperCase();
    }

    @api get user(){
            return this.displayUser;
    };
}