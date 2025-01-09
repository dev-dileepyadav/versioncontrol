public with sharing class OpenCageGeoCodeServics {
    
    public static void openCageGeoLocation(String accountId){
        Account account = [SELECT Id, Location__Latitude__s, Location__Longitude__s FROM Account WHERE Id =: accountId AND Location__Latitude__s != null AND Location__Longitude__s != null LIMIT 1];
        String queryParems = account.Location__Latitude__s+','+account.Location__Longitude__s;

        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndPoint(System.label.OpenCage_URL+'?key='+System.Label.OpenCage_API_Key+'&q='+queryParems+'&pretty=1');
        req.setHeader('Content-Type','application/json');
        Http http = new Http();
        HttpResponse res = http.send(req);
        String responceBody = res.getBody();
        Integer statusCode = res.getStatusCode();
        System.debug(responceBody);
    }
}