/**
 * Created by Sergey Krivorotov.
 *
 * Designed to create Account records through SOAP protocol.
 */

public with sharing class SalesforceService {

    private String userName;
    private String password;

    public SalesforceService(String userName, String password) {
        this.userName = userName;
        this.password = password;
    }

    public void createAccount(Map<String, String> fieldsAndValues) {
        String sessionId = getSessionId(userName, password);
        CalloutExecutor.execute(new CalloutSobject(sessionId, 'Account', fieldsAndValues));
    }

    private String getSessionId(String userName, String password) {
        if (userName == null || password == null) return null;
        return (String) CalloutExecutor.execute(new SalesforceLoginCallout(userName, password));
    }

}