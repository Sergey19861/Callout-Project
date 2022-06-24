/**
 * Created by Sergey Krivorotov.
 */

public abstract with sharing class Callout {
    public String endpoint;
    public HttpMethod method;
    public Map<String, String> headers;

    public abstract String buildRequestBody();
    public abstract Object parseResponse(String response);

    public HttpRequest buildHttpRequest() {
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod(method.name());
//        for(String headerKey: headers.keySet()) request.setHeader(headerKey, headers.get(headerKey));
//        request.setBody(buildRequestBody());
        return request;
    }

    public void logRequest() {
        //add all prorerties in IntegrationLog
    }
}