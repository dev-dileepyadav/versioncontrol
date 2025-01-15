import { LightningElement, api, wire } from 'lwc';
import { registerListener } from 'c/subs';
import { CurrentpageReference } from 'lightning/navigation'
export default class Sub extends LightningElement {

    @wire(CurrentpageReference)pageRef;

    textFromPub =  '';

    @api
    getPubValue(e){
        this.textFromPub = e;
    }
    connectedCallback(){
        registerListener('pubHit',this.getPubValue,this);
    }
}