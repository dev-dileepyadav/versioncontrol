import { LightningElement, wire } from 'lwc';
import Contact from '@salesforce/schema/Contact';
import Leadsource from '@salesforce/schema/Contact.LeadSource';
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import contactData from '@salesforce/apex/ContactController.getContactsForCustomDataTable';

const DEFAULT_ACTION = [{label:'All',checked:true,name:'all'}]

const columns = [{label:'First Name',fieldName:'FirstName',hideDefaultActions:true},
                {label:'Last Name',fieldName:'LastName',hideDefaultActions:true},
                {label:'Email',fieldName:'Email',hideDefaultActions:true},
                {label:'Phone',fieldName:'Phone',hideDefaultActions:true},
                {label:'Lead Source',fieldName:'LeadSource',hideDefaultActions:true,actions:[{DEFAULT_ACTION}]}];

export default class DataTableHeaderAction extends LightningElement {
    columns = columns;
    contactsData;
    error;
    leadSourceActions = [];
    loeadActionCompleted = false;
    contactAllData = [];

    @wire(contactData)wiredContacts({data,error}){
        if(data){
            this.contactsData = data;
            this.error = null;
            this.contactAllData = [...this.contactsData];
        }else if(error){
            this.error = error;
            this.contactsData = null;
        }
    }
    @wire(getObjectInfo,{objectApiName: Contact})
    contactObjectInfo;

    @wire(getPicklistValues,{recordTypeId: '$contactObjectInfo.data.defaultRecordTypeId', fieldApiName:Leadsource})
    wiredPickList({data,error}){
        if(data){
            this.leadSourceOptions = data.values;
            this.leadSourceActions = [];
            data.values.forEach(currentItem => {
                this.leadSourceActions.push({
                    label:currentItem.label,
                    checked:false,
                    name:currentItem.value
                });
            });
            this.columns.forEach(currentItem =>{
                if(currentItem.fieldName === 'LeadSource'){
                    currentItem.actions = [...currentItem.actions,...this.leadSourceActions]
                }
            });
    this.loeadActionCompleted = true;
            
        }else if(error){
            this.error = error;
            this.leadSourceOptions = null;
        }
    }
    
    handleHeaderAction(event){
        let actionName = event.detail.action.name;
        const coluDefination = event.detail.columnDefinition;
        console.log('coluDefination-->',coluDefination);
        const cols = [...this.columns];
        if(actionName === 'all'){
            this.contactsData = [...this.contactAllData];
        }else{
            this.contactAllData.filter(currentItem => actionName === currentItem['LeadSource']

            )
        }
        cols.find((currentItem) => currentItem.fieldName === 'LeadSource').actions.forEach(currentItem => {
            if(currentItem.name === actionName){
                currentItem.checked = true;
            }else{
                currentItem.checked = false;
            }
        });
        this.columns = [...cols];
    }

    get displayData(){
        if(this.contactsData && this.loeadActionCompleted === true){
            return true;
        }else{
            return false;
        }
    }
}