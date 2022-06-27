/**
 * Created by Sergey Krivorotov.
 *
 * Parent class for all Callouts. Extend this class to implement Callouts for CalloutExecutor.
 */

public abstract with sharing class Callout {

    protected String endpoint;
    protected String method;
    protected Map<String, String> headers;
    protected Map<String, String> secretMap;
    protected IntegrationLog__c log = new IntegrationLog__c();

    public abstract String buildRequestBody();
    public abstract Object parseResponse(String response);
    protected abstract Type getType();

    public IntegrationLog__c getLog() {
        return log;
    }

    public HttpRequest buildHttpRequest() {
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        log.CalloutType__c = getType().toString();
        log.Endpoint__c = request.getEndpoint();
        request.setMethod(method);
        if (headers != null) {
            for (String headerKey : headers.keySet()) request.setHeader(headerKey, headers.get(headerKey));
        }
        String requestBody = buildRequestBody();
        log.Request__c = requestBody;
        request.setBody(substituteSecretParams(requestBody));
        return request;
    }

    private String substituteSecretParams(String body) {
        if (secretMap == null) return body;
        for (String key : secretMap.keySet()) {
            body = body.replace('{!' + key + '}', secretMap.get(key));
        }
        return body;
    }
//permset, set Success filed, test, create SalesforceService with method createAccount(String name); calloutSobject, add project to Git
}