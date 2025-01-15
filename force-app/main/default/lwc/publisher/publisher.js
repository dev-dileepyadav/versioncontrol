import { LightningElement,wire } from 'lwc';
import { fireEvent } from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';
export default class Publisher extends LightningElement {

    @wire(CurrentPageReference)
    pageRef;


   
    handleChange(e){
        fireEvent(this.pageRef,'namePublisher',e.target.value);
    }
}