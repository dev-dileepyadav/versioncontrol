import { LightningElement, wire } from 'lwc';
import { fireEvent } from 'c/subs';
import { CurrentpageReference } from 'lightning/navigation'

export default class Pub extends LightningElement {
    @wire(CurrentpageReference)pageRef;

    text = ''
    handleChange(e){
        this.text = e.target.value;
        fireEvent(this.pageRef,'pubHit',this.text);
    }
}