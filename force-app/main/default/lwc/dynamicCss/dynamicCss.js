import { LightningElement } from 'lwc';

export default class DynamicCss extends LightningElement {
    divColor = 'backgroundColour';

    addHandler(){
        let element = this.template.querySelector('p');
        element.classList.add('greenBorder');
    }
    removeHandler(){
        let element = this.template.querySelector('p');
        element.classList.remove('greenBorder');
    }
    toggleHandler(){

        let element = this.template.querySelector('p');
        element.classList.toggle('greenBorder');
    }
}