import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import Latitude from '@salesforce/schema/Asset.Latitude';
import Longitude from '@salesforce/schema/Asset.Longitude';

export default class LocationCordinate extends LightningElement {

    latitudes;
    longitudes;
    mapMarkers = [];
    zoomLevel = '0';
    title = '';
    handleTitle(e){
        this.title = e.target.value;
    }
     handelStart(){

        let currentDate = new Date().toJSON().slice(0, 10);
        let CurrentDateAndTime = new Date().toJSON();
        console.log(currentDate);
         if(navigator.geolocation){
            navigator.geolocation.getCurrentPosition((position)=>{
                let latitude = position.coords.latitude;
                let longtitude = position.coords.longitude;
                this.latitudes = latitude;
                this.longitudes = longtitude;
                console.log('latitude',latitudes);
                console.log('longtitude',longitudes);
                
            })
        }
        setTimeout(()=>{
            const locationfield = {
                "Start_Location__Longitude__s":this.latitudes,
                "Start_Location__Latitude__s":this.longitudes,
                "Work_Date__c":currentDate,
                "Work_Date_And_Time__c":CurrentDateAndTime,
                "Location_Title__c":this.title
            }
            const accountRecordDetails = {apiName:"Location__c",fields:locationfield};

            this.mapMarkers = [
                {
                    location:{
                        Latitude:this.latitudes,
                        Longitude:this.longitudes
                    }
                }
            ]
            console.log('Title-->',this.title);

         createRecord(accountRecordDetails).then(x=>{
            console.log(x);
                const event = new ShowToastEvent({
                    title: 'Location Saved',
                    message:'Your current location saved.',
                    variant:'success'
                });
                this.dispatchEvent(event);
            console.log('Executing');
        }).catch((err)=>{
            console.log(JSON.stringify(err));
            const event = new ShowToastEvent({
                title: 'Location Can Not Save',
                message:'Your current location can not save.',
                variant:'error'
            });
            this.dispatchEvent(event);
            console.log('Executing with error');
        })
        },5000)
        
    }


    handleEnd(){
        let currentDate = new Date().toJSON().slice(0, 10);
        let CurrentDateAndTime = new Date().toJSON();
        console.log(currentDate);
         if(navigator.geolocation){
            navigator.geolocation.getCurrentPosition((position)=>{
                let latitude = position.coords.latitude;
                let longtitude = position.coords.longitude;
                this.latitudes = latitude;
                this.longitudes = longtitude;
                console.log('latitude',latitudes);
                console.log('longtitude',longitudes);
            })
        }
        setTimeout(()=>{
            const locationfield = {
                "End_Location__Longitude__s":this.longitudes,
                "End_Location__Latitude__s":this.latitudes,
                "Work_Date__c":currentDate,
                "Work_Date_And_Time__c":CurrentDateAndTime
            }
            const accountRecordDetails = {apiName:"Location__c",fields:locationfield};

            this.mapMarkers = [
                {
                    location:{
                        Latitude:this.latitudes,
                        Longitude:this.longitudes
                    }
                }
            ]

         createRecord(accountRecordDetails).then(x=>{
            console.log(x);
                const event = new ShowToastEvent({
                    title: 'Location Saved',
                    message:'Your current location saved.',
                    variant:'success'
                });
                this.dispatchEvent(event);
            console.log('Executing');
        }).catch((err)=>{
            console.log(JSON.stringify(err));
            const event = new ShowToastEvent({
                title: 'Location Can Not Save',
                message:'Your current location can not save.',
                variant:'error'
            });
            this.dispatchEvent(event);
            console.log('Executing with error');
        })
        },5000)
        
    }
}