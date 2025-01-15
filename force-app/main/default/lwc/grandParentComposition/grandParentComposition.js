import { LightningElement } from 'lwc';

export default class GrandParentComposition extends LightningElement {

    fireParentHandler(){
        console.log('Event handled at grand parent component');
    }
}