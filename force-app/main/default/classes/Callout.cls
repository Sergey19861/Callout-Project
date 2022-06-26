/**
 * Created by Sergey Krivorotov.
 *
 * Parent class for all Callouts. Extend this class to implement Callouts for CalloutExecutor.
 */

public abstract with sharing class Callout {

    protected String endpoint;
    protected String method;
    protected Map<String, String> headers;
    private Long calloutTime;

    public abstract String buildRequestBody();
    public abstract Object parseResponse(String response);
    protected abstract Type getType();

    public HttpRequest buildHttpRequest() {
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod(method);
        if (headers != null) {
            for (String headerKey : headers.keySet()) request.setHeader(headerKey, headers.get(headerKey));
            request.setBody(buildRequestBody());
        }
        System.debug('Request: ' + request.getEndpoint() + '\n' + request.getMethod() + '\n' + request.getBody());
        return request;
    }

    public IntegrationLog__c logCallout(HttpRequest request, HttpResponse response) {
        IntegrationLog__c log = new IntegrationLog__c();
        log.CalloutType__c = getType().toString();
        log.Endpoint__c = request.getEndpoint();
        log.Request__c = request.toString();
        log.Response__c = response.toString();
        log.ExecutionTime__c = calloutTime;
        return log;
    }

    public HttpResponse countCalloutTime(HttpRequest request) {
        Http http = new Http();
        Long startTime = System.now().getTime();
        HttpResponse response = http.send(request);
        calloutTime = System.now().getTime() - startTime;
        return response;
    }

}