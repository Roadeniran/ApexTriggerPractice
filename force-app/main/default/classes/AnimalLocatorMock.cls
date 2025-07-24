public class AnimalLocatorMock implements HttpCalloutMock {
    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"id":1,"name":"Lion"}');
        res.setStatusCode(200);
        return res;
    }
}
