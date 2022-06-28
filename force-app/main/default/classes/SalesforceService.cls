/**
 * Created by Sergey Krivorotov.
 *
 * Designed to create records of sObjects of various types using the SOAP protocol.
 */

public with sharing class SalesforceService {

    public class SalesforceServiceException extends Exception {
    }

    private String sessionId;

    public void createAccount(Map<String, String> fieldsAndValues) {
        if (sessionId != null) {
            CalloutExecutor.execute(new CalloutSFCrerateSObject(sessionId, 'Account', fieldsAndValues));
        } else {
            throw new SalesforceServiceException('Session Id is ' + sessionId);
        }
    }

    public void login(String userName, String password) {
        if (userName == null || password == null) return;
        sessionId = (String) CalloutExecutor.execute(new CalloutSFLogin(userName, password));
    }

    public void upsertLogs() {
        CalloutExecutor.upsertLogs();
    }

}