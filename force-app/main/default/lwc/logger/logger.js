import { LightningElement } from 'lwc';
import { log } from 'lightning/logger';

export default class Logger extends LightningElement {
    handleClick() {
        let msg = {
            type: "click",
            action: "Approve"
        }
        log(msg);
        console.log(msg)
   }
}