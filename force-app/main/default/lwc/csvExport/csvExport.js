import { LightningElement, wire } from 'lwc';
import getAccountData from '@salesforce/apex/AccountHelper.getAccountData';

const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Industry', fieldName: 'Industry'},
    { label: 'Phone', fieldName: 'phone', type: 'phone' }
];

export default class CsvExport extends LightningElement {

    columns = columns;
    data = [];
    error;
    @wire(getAccountData)wiredAccount({data,error}){
        if(data){
            this.data = data;
        }else if(error){
            this.error = error;
        }
    }

    get checkRecord(){
        this.data.length > 0 ? false : true;
    }

    clickHandler(){
        let downloadRecords = [];
        
        let selectedRows = [];
        selectedRows = this.template.querySelector('lightning-datatable').getSelectedRows();
        if(selectedRows.length > 0){
            downloadRecords = [...selectedRows];
        }else{
            downloadRecords = [...this.data];
        }

        // convert Array into CSV
        let csvFile = this.convertArrayToCsv(downloadRecords);
        this.createLiknForDownload(csvFile);
    }

    convertArrayToCsv(downloadRecords){
        let  csvHeader = Object.keys(downloadRecords[0]).toString();
        
        let csvBody = downloadRecords.map(item => Object.values(item).toString());
        
        let csvFile = csvHeader + "\n" + csvBody.join("\n")
        return csvFile;
     }
     createLiknForDownload(csvFile){
        const downloadLink = document.createElement('a');
        downloadLink.href = 'data:text/csv;charset=utf-8'+ encodeURI(csvFile);
        downloadLink.target = '_blank';
        downloadLink.download = 'Account_data.csv';
        downloadLink.click();
     }
}