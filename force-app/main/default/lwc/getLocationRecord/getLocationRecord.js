import { LightningElement } from 'lwc';
import GetLocationData from '@salesforce/apex/LocationHandler.GetLocationData';

const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Date And Time', fieldName: 'Work_Date_And_Time__c', type: 'date',
    typeAttributes:{
        year: "numeric",
        month: "long",
        day: "2-digit",
        hour: "2-digit",
        minute: "2-digit"
    }
     },
    { label: 'Start Longitude', fieldName: 'Start_Location__Longitude__s', type: 'Number' },
    { label: 'Start Latitude', fieldName: 'Start_Location__Latitude__s', type: 'Number' },
    { label: 'End Latitude', fieldName: 'End_Location__Latitude__s', type: 'Number' },
    { label: 'End Longitude', fieldName: 'End_Location__Longitude__s', type: 'Number' },
    { label: 'Location Title', fieldName: 'Location_Title__c', type: 'Text' },
];
export default class GetLocationRecord extends LightningElement {

    columns = columns;
    date;
    data;
    error;
    mapMarks = [];
    zoomLevel = '6'
    handleChange(e){
        this.date = e.target.value;
        console.log(this.date);
        GetLocationData({searchDate : this.date}).then((data)=>{
            let tempMarks = [];
            if(data){
                this.data = data;
                data.forEach(element => {
                    let marker = {
                        location:{
                            Latitude:element.Start_Location__Latitude__s,
                            Longitude:element.Start_Location__Longitude__s
                        }
                    }
                    tempMarks.push(marker);
                    this.mapMarkers = [
                        {
                            location:{
                                Latitude:element.Start_Location__Latitude__s,
                                Longitude:element.Start_Location__Longitude__s
                            }
                        }
                    ]
                });
                this.mapMarkers = tempMarks;
            }else if(error){
                this.error = error;
            }
        })
    }
}