public with sharing class ZendeskCreateTicket {

    public static void createTicket(TicketWrapper ticketWrapper){

        String header = 'dev.dileepyadav@gmail.com/token:8KaQAzlus4Yb09ssVGaDSIyhBiIIRGjeGRmpa3Yc';
        

        String requestBody = '{'+
		'    "ticket": {'+
		'        "comment": {'+
		'            "body": "'+ticketWrapper.body+'"'+
		'        },'+
		'        "priority": "'+ticketWrapper.priority+'",'+
		'        "subject": "'+ticketWrapper.subject+'"'+
		'    }'+
		'}';

        HttpRequest httpReq = new HttpRequest();
        httpReq.setEndPoint('https://vfvfvfv.zendesk.com/api/v2/tickets');
        httpReq.setMethod('POST');
        httpReq.setBody(requestBody);
        httpReq.setHeader('Content-Type','application/json');
        httpReq.setHeader('Accept','application/json');
        httpReq.setHeader('Authorization','Basic'+EncodingUtil.base64Encode(Blob.valueOf(header)));

        Http http = new Http();
        try{
            HttpResponse res = http.send(httpReq);
            if(res.getStatusCode() == 201){
                System.debug(res.getBody());
                //sucess
            }else{
                //Fail
                System.debug(res.getBody());
                System.debug(res.getStatus());
                System.debug(res.getStatusCode());
                System.debug(res.toString());
            }
        }catch(System.calloutException ex){

        }catch(System.Exception ex){

        }

       

    }

    public class TicketWrapper{
        public String  body;
        public String priority;
        public String subject;
        public String name;
        public String email;

    }
}