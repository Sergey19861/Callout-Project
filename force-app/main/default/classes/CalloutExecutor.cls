/**
 * Created by Sergey Krivorotov.
 */

public with sharing class CalloutExecutor {
    private static List<IntegrationLog__c> logsList = new List<IntegrationLog__c>();

    public static Object execute(Callout callout) {
        HttpRequest request = callout.buildHttpRequest();
        HttpResponse response = callout.countCalloutTime(request);
        IntegrationLog__c log = callout.logCallout(request, response);
        logsList.add(log);
        return callout.parseResponse(response.getBody());
    }

    public static void insertLogs() {
        try {
            insert logsList;
        } catch (DmlException e) {
            System.debug('DML Error: ' + e.getMessage() + '. ' + e.getStackTraceString());
        }
    }

}