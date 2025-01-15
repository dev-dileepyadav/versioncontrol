import { LightningElement } from 'lwc';

export default class ToDoApplication extends LightningElement {
    
    taskName = '';
    taskDate = null;

    incompleteTask = [];
    completeTask = [];


    handleChange(event){
        let {name,value} = event.target;
        if(name = 'taskName'){
            this.taskName = value;
        }else if(name == 'taskDate'){
            this.taskDate = value;
        }
    }


    addTaskHandler(){
        if(!this.taskDate){
            this.taskDate = new Date().toISOString.slice(0,10);
        }
        if(this.validateTask()){
            this.incompleteTask = [...this.incompleteTask,{
                taskName: this.taskName,
                taskDate: this.taskDate
            }];
            this.resetTaskHandler();
            let sortedArray = this.sortTask(this.incompleteTask);
            this.incompleteTask = [...sortedArray];
        }
    }

    validateTask(){
        let isValidate = true;
        let element = this.template.querySelector('.taskName');
        if(!this.taskName){
            isValidate = false;
        }else{
           let taskItem =  this.incompleteTask.find(currItem => currItem.taskName === this.taskName && currItem.taskDate === this.taskDate);
           if(taskItem){
            isValidate = false;
            element.setCustomalidity('Task is already available');
           }
        }
        if(isValidate){
            element.setCustomalidity("");
        }
        element.reportValidity('');
        return isValidate;
    }

    sortTask(inputArray){
        let sortedArray = inputArray.sort((a,b)=>{
            const datea = new Date(a.taskDate);
            const dateb = new Date(b.taskDate);
            return datea - dateb;
        });
        return sortedArray;
    }
    resetTaskHandler(){
        this.taskName = '';
    this.taskDate = null;
    }
}