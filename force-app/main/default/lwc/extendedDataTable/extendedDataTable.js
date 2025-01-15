import { LightningElement, track, wire } from 'lwc';
import accountDetails from '@salesforce/apex/AccountHelper.getAccountData';

const columns = [
    { label: 'Id', fieldName: 'Id' },
    { label: 'Name', fieldName: 'Name', type: 'text' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Industry', fieldName: 'Industry', type: 'picklist',
    typeAttributes: {
        name: 'Industry',
        label: 'Industry',
        placeholder: 'Select Industry',
        index: 0,
        variant: 'label-hidden',
        options: [
            { label: 'Education', value: 'Education' },
            { label: 'Banking', value: 'Banking' },
            { label: 'Aparel', value: 'Aparel' },
            { label: 'Technology', value: 'Technology' }
        ]
    } },
    {label: 'Image',fieldName:'imageUrl',type:'image',
    typeAttributes:{
        height: 50,
        width: 50,
        alt: 'Account Image'
    }}
];
export default class ExtendedDataTable extends LightningElement {

    error;
    @track dataList = [];
    @track columnsList = columns;

    @wire(accountDetails)
    wiredAccount({data,error}){
        if(data){
            this.dataList = data.map(item =>{
                return {
                    ...item,
                    imageUrl: 'https://www.pantherschools.com/wp-content/uploads/2022/02/cropped-logoblack.png'
                };
            });
        }else if(error){
            this.error = error;
        }
    }

    handleSelect(event) {
        event.preventDefault();
        let detail = event.detail;
        console.log(JSON.stringify(detail));
    }
}