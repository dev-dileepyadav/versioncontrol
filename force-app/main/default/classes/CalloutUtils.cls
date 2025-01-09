public with sharing class CalloutUtils {
    
    public static HttpRequest prepareRequest(String endPoint, String method,String body, String accept, String contentType){
        HttpRequest req = new HttpRequest();
        req.setEndPoint(endPoint);
        req.setMethod(method);
        req.setHeader('Content-Type',contentType);
        if(!String.isBlank(accept)){
            req.setHeader('Accept', accept);
        }
        if(!String.isBlank(body)){
            req.setBody(body);
        }
        return req;

    }
}