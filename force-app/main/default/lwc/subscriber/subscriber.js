import { LightningElement,wire } from 'lwc';
import { registerListener,unregisterAllListeners } from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';
export default class Subscriber extends LightningElement {

    @wire(CurrentPageReference)
    pageRef;


    getName = '';
    connectedCallback(){
        registerListener('namePublisher',this.getData,this)
    }

    disconnectedCallback(){
        unregisterAllListeners(this)
    }
    getData(data){
        this.getName = data;
    }
}