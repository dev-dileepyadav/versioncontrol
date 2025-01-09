public with sharing class CurrencyAPIService {

    public static  final String END_POINT = 'https://open.er-api.com/v6/latest/USD';
    
    public static void getExchangeRate(){
        // This is only for callouts
        HttpRequest httpReq = new HttpRequest();
        //Step 1.1 send the endPoint
        httpReq.setEndPoint(END_POINT);
        //Step 1.2 Set the header
        httpReq.setHeader('Content-Type','application/json');// It's take 2 parameter
        //httpReq.setHeader('Accept','application/json');// If we are not sure what is the format of responce then we put Accept as first parameter and second parameter is what format we want to accept
        httpReq.setMethod('GET');
        // Step 2 Send the request
        Http http = new Http();
        try{
            HttpResponse httpRes =  http.send(httpReq);
            String responseBody = httpRes.getBody();
            System.debug('Response is - '+responseBody);
            Integer responseCode = httpRes.getStatusCode();
            System.debug('Response Code is-->'+ responseCode);
            String status = httpRes.getStatus();
            System.debug('The status is -->'+ status);

        }catch(System.CalloutException ex){
            System.debug('Exception is '+ex.getMessage());
        }catch(System.exception ex){
            System.debug('Exception is '+ex.getMessage());
        }
    }

    
}