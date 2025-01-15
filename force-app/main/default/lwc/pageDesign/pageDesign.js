import { LightningElement } from 'lwc';

export default class PageDesign extends LightningElement {
    get options() {
        return [
            { label: 'choose one...', value: '' },
            { label: 'one', value: '1' },
            { label: 'two', value: '2' },
            { label: 'three', value: '3' },
        ];
    }
}