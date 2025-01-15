import { LightningElement } from 'lwc';

export default class ChangeDatetoString extends LightningElement {
        selectedDate;
        formattedDate;
        dataType;
        dateInput

        isDateType = false;
        handleDateChange(event) {
            this.selectedDate = event.target.value;
            if(isDateType){
                this.formatDate(this.selectedDate)
            }else{
                this.formattedDate = this.formatDat(this.selectedDate);
            }
        }

        
        handleCheck(e){
            this.dataType = e.target.checked ? 'string' : 'date';
            if(this.dataType == 'string'){
                this.isDateType = true;   
            }
        }
        
    
        formatDat(dateString) {
            if (dateString) {
                const dateObj = new Date(dateString);
                const formattedDate = new Intl.DateTimeFormat('en-GB', { day: 'numeric', month: 'short', year: 'numeric' }).format(dateObj);
                return formattedDate;
            }
            return '';
        }

        formatDate(dateString) {
            this.dateInput = dateString;
    
            // Ensure the input is exactly 8 digits
            if(this.dateInput.length === 8) {
                const month = this.dateInput.substring(0, 2);
                const day = this.dateInput.substring(2, 4);
                const year = this.dateInput.substring(4, 8);
    
                // Create a Date object
                const dateObject = new Date(`${year}-${month}-${day}`);
    
                // Check if the date is valid
                if(!isNaN(dateObject.getTime())) {
                    this.formattedDate = dateObject.toLocaleDateString();
                } else {
                    this.formattedDate = 'Invalid Date';
                }
            } else {
                this.formattedDate = 'Invalid Format (MMDDYYYY required)';
            }
        }
    }