public with sharing class ZendeskCaseCreate {
    
    public class TicketWraper{
        public String body;
        public String subject;
        public String priority;
        public String name;
        public String email;
        public String status;
    }

    public static void CreateCase(TicketWraper wrapper){

        String body = '{'+
            '"ticket": {'+
            '"name": "'+wrapper.name+'",'+
            '"email": "'+wrapper.email+'",'+
            '"status": "'+wrapper.status+'",'+
            '"priority": "'+wrapper.priority+'",'+
            '"subject": "'+wrapper.subject+'",'+
            '"body": "'+wrapper.body+'",'+
            '}'+
            '}';
           
    }
}