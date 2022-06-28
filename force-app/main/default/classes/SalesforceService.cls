/**
 * Created by Sergey Krivorotov.
 *
 * Designed to create Account records through SOAP protocol.
 */

public with sharing class SalesforceService {

    private String sessionId;

    public void createAccount(Map<String, String> fieldsAndValues) {
        CalloutExecutor.execute(new SObjectCallout(sessionId, 'Account', fieldsAndValues));
    }

    public void login(String userName, String password) {
        if (userName == null || password == null) return;
        sessionId = (String) CalloutExecutor.execute(new CalloutSFLogin(userName, password));
    }

    public void upsertLogs() {
        CalloutExecutor.upsertLogs();
    }

}