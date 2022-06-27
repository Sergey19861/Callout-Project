/**
 * Created by Sergey Krivorotov.
 *
 * Designed to execute callout and log creation.
 */

public with sharing class CalloutExecutor {

    private static List<IntegrationLog__c> logsList = new List<IntegrationLog__c>();

    public static Object execute(Callout callout) {
        Http http = new Http();
        HttpRequest request = callout.buildHttpRequest();
        IntegrationLog__c log = callout.getLog();
        logsList.add(log);
        Long startTime = System.now().getTime();
        try {
            HttpResponse response = http.send(request);
            log.ResponseStatusCode__c = response.getStatusCode();
            log.ResponseStatus__c = response.getStatus();
            log.Response__c = response.getBody();
            log.ExecutionTime__c = System.now().getTime() - startTime;
            return callout.parseResponse(response.getBody());
        } catch (Exception e) {
            log.ErrorMessage__c = e.getMessage() + '\n' + e.getStackTraceString();
        }
        return null;
    }

    public static void insertLogs() {
        try {
            insert logsList;
            logsList = new List<IntegrationLog__c>();
        } catch (DmlException e) {
            System.debug('DML Error: ' + e.getMessage() + '. ' + e.getStackTraceString());
        }
    }

}