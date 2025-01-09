public with sharing class ZendeskIntegrationUtilsl {
    
    public static void createTicket(TicketWrapper ticketWrapper){

        String  header = System.label.zendeskUrl+':'+System.label.zendesk_APITopken;
        Blob headerValue = Blob.valueOf(header);

        String requestBody = '{'+
		'    "ticket": {'+
		'        "comment": {'+
		'            "body": "'+ticketWrapper.body+'"'+
		'        },'+
		'        "priority": "'+ticketWrapper.priority+'",'+
		'        "subject": "'+ticketWrapper.subject+'",'+
		'        "requester": {'+
		'            "locale_id": 8,'+
		'            "name": "'+ticketWrapper.name+'",'+
		'            "email": "'+ticketWrapper.email+'"'+
		'        }'+
		'    }'+
		'}';

        System.debug('Request Body\n'+requestBody);
        HttpRequest httpReq = new HttpRequest();
        httpReq.setEndpoint('https://sdfefdf.zendesk.com/api/v2/tickets');
        httpReq.setMethod('POST');
        httpReq.setBody(requestBody);
        httpReq.setHeader('Content-Type','application/json');
        httpReq.setHeader('Accept','application/json');
        httpReq.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(Blob.valueOf(header)));

        Http http = new Http();

        try{
            HttpResponse httpRes = http.send(httpReq);
            if(httpRes.getStatusCode() == 201){
                System.debug(httpRes.getBody());
            }else {
                {
                    System.debug(httpRes.getBody());
                    System.debug(httpRes.getStatusCode());
                }
            }

        }catch(system.calloutException ex){
            System.debug('Callout Exception'+ex);
        }catch(System.exception ex){
            System.debug('System Exception'+ex);
        }
        
    }

    public class TicketWrapper{
        public String name;
        public String subject;
        public String body;
        public String priority;
        public String email;
        
    }

    
}