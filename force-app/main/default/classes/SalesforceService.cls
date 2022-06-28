/**
 * Created by Sergey Krivorotov.
 *
 * Designed to create Account records through SOAP protocol.
 */

public with sharing class SalesforceService {

    private String sessionId;

    public void createAccount(Map<String, String> fieldsAndValues) {
        CalloutExecutor.execute(new CalloutSobject(sessionId, 'Account', fieldsAndValues));
    }

    public String login(String userName, String password) {
        if (userName == null || password == null) return null;
        return (String) CalloutExecutor.execute(new SalesforceLoginCallout(userName, password));
    }

    public void upsertLogs() {
        CalloutExecutor.upsertLogs();
    }

}