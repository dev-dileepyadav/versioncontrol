global with sharing class PostExampleMockGenerator implements HttpCallOutMock{

    global httpResponse respond(HttpRequest req){
        HttpResponse res = new HttpResponse();
        res.setBody('{"PostRes": "Hi there"}');
        res.setStatusCode(200);
        return res;
    }
}