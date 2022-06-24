/**
 * Created by Sergey Krivorotov.
 */

public abstract with sharing class Callout {

    public class CustomCalloutException extends Exception {}

    public String endpoint;
    public HttpMethod method;
    public Map<String, String> headers;
    private Long calloutTime;

    public abstract String buildRequestBody();
    public abstract Object parseResponse(String response);

    public HttpRequest buildHttpRequest() {
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod(method.name());
        if (headers != null) {
            for (String headerKey : headers.keySet()) request.setHeader(headerKey, headers.get(headerKey));
            request.setBody(buildRequestBody());
        }
        return request;
    }

    public IntegrationLog logCallout(HttpRequest request, HttpResponse response) {
        IntegrationLog log = new IntegrationLog();
        log.calloutType = getType();
        log.endpoint = request.getEndpoint();
        log.request = request;
        log.response = response;
        log.executionTime = calloutTime;
        return log;
    }

    public HttpResponse countCalloutTime(HttpRequest request) {
        Http http = new Http();
        Long startTime = System.now().getTime();
        HttpResponse response = http.send(request);
        calloutTime = System.now().getTime() - startTime;
        return response;
    }

    protected abstract Type getType();

}