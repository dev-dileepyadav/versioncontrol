import { LightningElement } from 'lwc';

export default class ParentComposition extends LightningElement {
    fireDivHandler(){
        console.log('Event handled in Parent at div level');
    }

    fireChildHandler(){
        console.log('Event handlede in parent at child level');
    }
}