@restResource(urlMapping = '/CreateLead/')
global class CreateLeadAPI {

    @httpGet
    global static String getLead(){
        String objectNAme;
        id i;
        
        
       RestRequest req = RestContext.request;
        Restresponse res = RestContext.response;
        
        objectName = req.headers.get('objectName');
        i = req.headers.get('id');
       
		String q = 'SELECT name FROM '+ objectNAme+ ' Where id =: i '+'LIMIT 1';
        
        sObject s = database.query(q);
        
        String jsonResponse = '{\"name\":\"'+s.get('Name')+'\"}';
        
        return jsonResponse;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    @httpPost
    global static Lead doPost(){
        
        String fName,lName,company;
        String fieldName,fieldValue;
        
        restRequest req = RestContext.request;
        System.debug('request' + req);
        restResponse res = RestContext.response;
        
        System.debug('Response' + res);
        
        String jsonBody = req.requestBody.toString();
        System.debug('Body is :' + jsonBody);
        
        JSONParser parser = JSON.createParser(jsonBody);
        System.debug('parser : ' + parser);
        
        while(parser.nextToken() != null){
            if(parser.getCurrentToken() != JSONToken.END_OBJECT){
                fieldName = parser.getCurrentName();
                fieldValue = parser.getText();
                if(fieldName == 'firstName'){
                   fName = fieldValue;
                }else if(fieldName == 'lastName'){
                    lName = fieldValue;
                }else if(fieldname == 'company'){
                    company = fieldValue;
                }
            }
        }
        
        Lead l = new Lead();
        l.FirstName = fName;
        l.LastName = lName;
        l.Company = company;
        insert l;
        return l;
    }
}