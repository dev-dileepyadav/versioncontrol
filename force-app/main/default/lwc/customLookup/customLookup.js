import { LightningElement, api, wire } from 'lwc';
import searchRecords from '@salesforce/apex/CustomLookUpController.searchRecords';
import {ShowToastEvent} from 'lightning/platformshowToastEvent';

const DELAY = 300;
export default class CustomLookup extends LightningElement {
    searchKey;
    @api objectApiName = 'Account';
    hasRecords = false;
    searchOutPut = [];
    selectedRecords = [];
    @api placeholder = 'Search Account';
    @api label = 'Account';
    @api iconName = 'standard:account';
    delayTimeOut;

    displayOptions = false;

    @wire(searchRecords,{searchKey:'$searchKey',objectApiName:'$objectApiName'})
    searchResult({data,error}){
        if(data){
            console.log('data-->',data);
            this.hasRecords = data.length > 0 ? true : false;
            this.searchOutPut = data;
        }else if(error){
            console.log(error);
        }
    }
    
    changeHandler(e){
        clearTimeout(this.delayTimeOut);
        let value = e.target.value;
       this.delayTimeOut =  setTimeout(()=>{
            this.searchKey = value;
        },DELAY)
    }

handleClick(e){

    let recoredId = e.target.getAttribute('data-recordid');
    console.log(recoredId);
    if(this.validateDuplicate(recoredId)){
        let selectedRecord = this.searchOutPut.find(currentItem => currentItem.Id == recoredId)
    let pill = {
            type: 'icon',
            label: selectedRecord.Name,
            name: recoredId,
            iconName: this.iconName,
            alternativeText: selectedRecord.Name
    };
    this.selectedRecords = [...this.selectedRecords,pill];
    }
    
}

get showPillContainer(){
    return this.selectedRecords.length > 0 ? true : false;
}

handleItemRemove(e){
    const index = e.detail.index;
    this.selectedRecords.splice(index,1);
}

validateDuplicate(selectedRecord){
    let isValid = true;
    let isRecordAlreadySelected = this.selectedRecords.find(currentItem => currentItem.Name === selectedRecord);

    if(isRecordAlreadySelected){
        isValid = false;

        this.dispatchEvent(new ShowToastEvent({
            title: "Error",
            message: "Value already selected",
            variant: "error"
        }));
    }else{
        isValid = true;
    }
}

}