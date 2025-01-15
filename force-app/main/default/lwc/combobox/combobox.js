import { LightningElement, api } from 'lwc';

export default class Combobox extends LightningElement {
    @api name;
    @api options;
    @api variant;
    @api label;
    @api value;
    @api placeholder;
    @api index;

    handleChange(e){
        e.preventDefault();
        let value = e.target.value;
        const pickList = new CustomEvent('select',{
            detail:{value : value,
                    index : this.index},
                    bubbles:true,
                    composed:true,
                    cancelable:true
        });
        this.dispatchEvent(pickList);
    }
}