public class DataBaseClass {
    
    public static void createContacts(){

        List<contact> conList = new List<contact>();
    
    contact con1 = new contact();
    con1.LastName = 'Data';
    conList.add(con1);     
        
        contact con2 = new contact();
         con2.LastName = '';
        conList.add(con2);
       
           List<database.SaveResult> saveResult = database.insert(conList, false);
        integer length = conList.size();
        for(integer i = 0; i<length; i++){
            database.SaveResult sr = saveresult.get(i);
            contact contactRecord = conList.get(i);            
            if(sr.issuccess()){
                System.debug('saved data is : '+ sr.getId());
            }else{
                for(database.Error err : sr.getErrors()){
                    System.debug('Following contact has erro '+ contactRecord);
                   //System.debug('The following error has occoured');
                    //System.debug('Error code '+err.getStatusCode()+ ' '+ err.getmessage());
                    //System.debug('Fildes that get affected by the DML '+ err.getfields());
                }
            }
        }
        }
    
    public static void dynamicQuery(String field, String objectApiName){
        
        String dataQuery = 'SELECT Id ' + field + 'FROM' + objectApiName + 'LIMIT 10';
        List<sobject> results = database.query(dataQuery);
            System.debug(results);
    }
        
    }