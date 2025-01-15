public class AnimalsCallouts {
    public static httpResponse makeCallOut(){
        http http = new http();
        httpRequest req = new httpRequest();
        req.setEndPoint('https://th-apex-http-callout.herokuapp.com/animals');
        req.setMethod('GET');
        httpResponse res = http.send(req);
        if(res.getStatusCode() == 200){
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            List<object> animals = (List<Object>) results.get('animals');
            for(object animal : animals){
                System.debug(animal);
            }
            
        }
        return res;
    }
    
    public static httpResponse makePostCallOut(){
        http http = new http();
        httpRequest req = new httpRequest();
        req.setEndPoint('https://th-apex-http-callout.herokuapp.com/animals');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json;charset=UTF-8');
        req.setBody('{"name":"mighty moose"}');
        HttpResponse res = http.send(req);
        if(res.getStatusCode() != 201){
            System.debug('The status code returned was not expected: ' + res.getStatusCode() + ' ' + res.getStatus());
        }else{
            System.debug(res.getBody());
        }
        return res;
    }
    
}