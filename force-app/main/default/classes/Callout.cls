/**
 * Created by Sergey Krivorotov.
 */

public abstract with sharing class Callout {
    public String endpoint;
    public String method; //Enum?
    public String headerKey; //Enum?
    public String headerValue;

    public abstract String buildRequestBody();
    public abstract Object parseResponse(String response);

    public HttpRequest buildHttpRequest() {
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod(method);
        request.setHeader(headerKey, headerValue);
        request.setBody(buildRequestBody());
        return request;
    }
}