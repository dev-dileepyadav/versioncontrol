import { LightningElement } from 'lwc';

export default class ChildComposition extends LightningElement {

    handleClick(){
        let myCustomEvent = new CustomEvent('fireevent',{
            bubbles:true,
            composed: true
        });
        this.dispatchEvent(myCustomEvent);
    }
}