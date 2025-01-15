import { LightningElement } from 'lwc';

export default class Pdfshower extends LightningElement {

    link = "";
    handleClick(e){
        this.link = e.target.value;
    }

    get siteLink(){
        return this.link;
    }
}