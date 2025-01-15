import { LightningElement } from 'lwc';
import { api } from 'lwc';
import LightningModal from 'lightning/modal';
export default class LwcModalprimary extends LightningModal {
    @api content;

    handleOkay() {
        this.close('okay');
    }
}