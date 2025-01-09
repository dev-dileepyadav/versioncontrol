@RestResource(urlMapping='/freshWorks/*')
global with sharing class FreshWorksCallOut {
   

    @httppost
    global static string getPost(String Name,String description,String subject, String email){
        
        HttpRequest req = new HttpRequest();
                req.setEndpoint('callout:FreshWorks/api/v2/tickets'); // When we want to use named cred then we use callout: before the endpoint and after the callout: we use the name of the name cred
                req.setHeader('Content-Type','application/json');
                req.setHeader('Accept', 'application/json');
                req.setMethod('POST');

        Http http = new Http();
        String requestBody = '{"description":'+' "' + description +'" ' +' ,"subject": ' +' "'+ subject +  '" '+ ',"name":' + ' "' + Name + '" ' + ',"email": '+' " '+ email +' ", "priority": 1, "status": 2, "cc_emails": ["ram@freshdesk.com","diana@freshdesk.com"]}';
        req.setBody(requestBody);
        HttpResponse res = http.send(req);
        System.debug(res.getBody());
        System.debug(res.getStatusCode());
        return res.getStatus();
        }
}