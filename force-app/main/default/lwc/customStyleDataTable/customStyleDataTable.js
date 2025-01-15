import { LightningElement, wire } from 'lwc';
import getContactsForCustomDataTable from '@salesforce/apex/ContactController.getContactsForCustomDataTable';

const columns = [
    { label: 'Contact Name', type: "customName",typeAttributes: {
        contactName:{
            fieldName: "Name"
        }
    }},
    { label: 'Account Name', fieldName: 'accountLink', type:'url', typeAttributes:{
        label:{
            fieldName : "accountName"
        },
       target: '_blank'
    }
},
    { label: 'Title', fieldName: 'Title', cellAttributes : {
        class : {
            fieldName : "titleColour"
        }
    }},
    { label: 'Rank', fieldName: 'Rank__c', type:"customRank",typeAttributes:{
        rankIcon: {
            fieldName: "rankIcons"
    }}
},
    { label: 'Picture', type:"customImg",typeAttributes:{
        imageURL : {
            fieldName: 'Picture__c'
        }
    },
    cellAttributes : {
        alignment : "center"
    }
}
];

export default class CustomStyleDataTable extends LightningElement {

    columns = columns;

    contacts;
    error;

    @wire(getContactsForCustomDataTable)
    wiredContacts({data,error}){
        if(data){
           this.contacts =  data.map((record)=>{
                let accountLink = "/"+record.AccountId;
                let accountName = record.Account.Name;
                let titleColour = "slds-text-color_success";
                let rankIcons = record.Rank__c > 5 ? "utility:ribbion" : "";
                return {
                    ...record,
                    accountLink : accountLink,
                    accountName : accountName,
                    titleColour : titleColour,
                    rankIcons: rankIcons
                };
            });
            console.log('Data -->',data);
        }else if(error){
            this.error = error;
            this.data = null;
        }
    }
}