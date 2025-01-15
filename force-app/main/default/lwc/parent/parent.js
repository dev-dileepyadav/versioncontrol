import { LightningElement, api , wire} from 'lwc';
import { getPicklistValues } from "lightning/uiObjectInfoApi";
import TYPE_FIELD from '@salesforce/schema/Account.Type';

export default class Parent extends LightningElement {
    
    @wire(getPicklistValues, {
        recordTypeId: '012000000000000AAA',
        fieldApiName: TYPE_FIELD
    })
    picklistValues;
    /*
    handleClick(){
        console.log('clicked');
        let firstName = this.template.querySelector('.fn').value;
        let lastName = this.template.querySelector('.ln').value;

        let name = {
            firstNames:firstName,
            lastNames:lastName
        };
       this.template.querySelector('c-child').getDataFromParent(name);
    }
    

    options = [
        {
          label: 'Option 1',
          value: 'option1'
        },
        {
          label: 'Option 2',
          value: 'option2'
        },
        {
          label: 'Option 3',
          value: 'option3'
        },
        {
            label: 'Option 4',
            value: 'option4'
          },
          {
            label: 'Option 5',
            value: 'option5'
          },
          {
            label: 'Option 6',
            value: 'option6'
          }
      ];
    */
      selectedOptions = [];
    
      handleChange(event) {
        this.selectedOptions = event.detail;
        console.log('Event -->',JSON.stringify(event.detail));
      }
}