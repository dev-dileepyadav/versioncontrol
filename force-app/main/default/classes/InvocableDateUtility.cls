public class InvocableDateUtility {

     @invocablemethod(label='Date utility' description = 'Date utility class' category = 'Date')
    public static void welcomeMessage(List<inputClass> inputs){
        Date outPutDate;
        inputClass input = inputs.get(0);
        
        if(input.operationType == 'inputDate'){
            
        }
        System.debug('Zero Index--> '+input);
        //Out put -  Index--> inputClass:[inputDate=2024-01-11 00:00:00, numberofDays=10, operationType=add]
    }
    
    public class inputClass{
        @invocablevariable(label='Input Date' required = true description='Provide the Date on that you want to performe operation')
        public Date inputDate;
        
         @invocablevariable(label='Operation Type' required = true description='Provide the operation type')
        public String  operationType;
        
         @invocablevariable(label='Number of Days' required = true description='Provide the number of days')
        public Integer numberofDays;
    }
}