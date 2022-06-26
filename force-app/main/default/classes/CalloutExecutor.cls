/**
 * Created by Sergey Krivorotov.
 *
 * Designed to execute callout and log creation.
 */

public with sharing class CalloutExecutor {

    private class CalloutExecutorException extends Exception {}

    private static List<IntegrationLog__c> logsList = new List<IntegrationLog__c>();

    public static Object execute(Callout callout) {
        HttpRequest request = callout.buildHttpRequest();
        HttpResponse response = callout.countCalloutTime(request);
        IntegrationLog__c log = callout.logCallout(request, response);
        logsList.add(log);
        return callout.parseResponse(response.getBody());
    }

    public static void insertLogs() {
        if (logslist.size() > 0) {
            try {
                insert logsList;
            } catch(DmlException e) {
                System.debug('DML Error: ' + e.getMessage() + '. ' + e.getStackTraceString());
            }
        } else {
            throw new CalloutExecutorException('Empty Logs List. Size: ' + logsList.size());
        }
    }

}