/**
 * Created by Sergey Krivorotov.
 */

public with sharing class IntegrationLog {
    public Type calloutType;
    public String endpoint;
    public HttpRequest request;
    public HttpResponse response;
    public Long executionTime;
}