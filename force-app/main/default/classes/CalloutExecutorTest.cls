/**
 * Created by Sergey Krivorotov.
 *
 * Contains test logic for CalloutExecutor.
 */

@IsTest
private class CalloutExecutorTest {

    @IsTest
    static void testCalloutRates() {
        String responseBody = '{' +
                '"eur": {' +
                '"code": "EUR",' +
                '"alphaCode": "EUR",' +
                '"numericCode": "978",' +
                '"name": "Euro",' +
                '"rate": 0.95107140705398,' +
                '"date": "Thu, 23 Jun 2022 23:55:02 GMT",' +
                '"inverseRate": 1.051445761678' +
                '}' +
                '}';
        MockFactory mock = new MockFactory(200, 'OK', responseBody, new Map<String, String>());
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        Map<String, CalloutRates.Rate> rates = (Map<String, CalloutRates.Rate>) CalloutExecutor.execute(new CalloutRates('usd'));
        CalloutExecutor.upsertLogs();
        IntegrationLog__c logs = [SELECT Endpoint__c FROM IntegrationLog__c];
        Test.stopTest();

        System.assertEquals('EUR', rates.get('eur').code);
        System.assertEquals(978, rates.get('eur').numericCode);
        System.assertNotEquals('USD', rates.get('eur').alphaCode);
        System.assertEquals('callout:RatesService1/daily/usd.json', logs.Endpoint__c);
    }

    @IsTest
    static void testCalloutSFLogin() {
        String responseBody = '<soapenv:Body>' +
                '<loginResponse>' +
                '<result>' +
                '<passwordExpired>false</passwordExpired>' +
                '<sandbox>true</sandbox>' +
                '<sessionId>SESSION_ID_REMOVED</sessionId>' +
                '<userId>0051k000008XYGGAA4</userId>' +
                '</result>' +
                '</loginResponse>' +
                '</soapenv:Body>';
        MockFactory mock = new MockFactory(200, 'OK', responseBody, new Map<String, String>());
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        String sessionId = (String) CalloutExecutor.execute(new CalloutSFLogin('TestUser', 'TestPassword'));
        CalloutExecutor.upsertLogs();
        IntegrationLog__c logs = [SELECT Endpoint__c FROM IntegrationLog__c];
        Test.stopTest();

        System.assertEquals(sessionId, 'SESSION_ID_REMOVED');
        System.assertEquals('callout:SalesForceOrg/', logs.Endpoint__c);
    }

    @IsTest
    static void testSalesforceService() {
        String responseBody = '<soapenv:Body>' +
                '<loginResponse>' +
                '<result>' +
                '<passwordExpired>false</passwordExpired>' +
                '<sandbox>true</sandbox>' +
                '<sessionId>SESSION_ID_REMOVED</sessionId>' +
                '<userId>0051k000008XYGGAA4</userId>' +
                '</result>' +
                '</loginResponse>' +
                '</soapenv:Body>';
        MockFactory mock = new MockFactory(200, 'OK', responseBody, new Map<String, String>());
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        SalesforceService service = new SalesforceService();
        service.login('TestUser', 'TestPassword');
        service.createAccount(new Map<String, String>{
                'Name' => 'Salesforce Service', 'NumberOfEmployees' => '250'
        });
        service.upsertLogs();
        List<IntegrationLog__c> logs = [SELECT Endpoint__c FROM IntegrationLog__c];
        Test.stopTest();

        System.assertEquals(2, logs.size());
        System.assertEquals('callout:SalesForceOrg/', logs[1].Endpoint__c);
    }

    @IsTest
    static void testSalesforceServiceNegative() {
        String result = '';
        MockFactory mock = new MockFactory(200, 'OK', '', new Map<String, String>());
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        try {
            SalesforceService service = new SalesforceService();
            service.login('TestUser', 'TestPassword');
            service.createAccount(new Map<String, String>{
                    'Name' => 'Salesforce Service', 'NumberOfEmployees' => '250'
            });
        } catch (Exception e) {
            result = e.getMessage();
            System.debug('Result: ' + result);
        }
        Test.stopTest();

        System.assert(result.contains('Service wasn’t logged in'), 'Service logged in');
    }

}