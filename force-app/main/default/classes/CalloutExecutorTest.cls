/**
 * Created by Sergey Krivorotov.
 *
 * Contains test logic for CalloutExecutor.
 */

@IsTest
private class CalloutExecutorTest {

    @IsTest
    static void testRatesCallout() {
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
        Map<String, RatesCallout.Rate> rates = (Map<String, RatesCallout.Rate>) CalloutExecutor.execute(new RatesCallout('usd'));
        CalloutExecutor.insertLogs();
        IntegrationLog__c logs = [SELECT Endpoint__c FROM IntegrationLog__c];
        Test.stopTest();

        System.assertEquals('EUR', rates.get('eur').code);
        System.assertEquals(978, rates.get('eur').numericCode);
        System.assertNotEquals('USD', rates.get('eur').alphaCode);
        System.assertEquals('callout:RatesService1/daily/usd.json', logs.Endpoint__c);
    }

    @IsTest
    static void testSalesforceLoginCallout() {
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
        String sessionId = (String) CalloutExecutor.execute(new SalesforceLoginCallout('TestUser', 'TestPassword'));
        CalloutExecutor.insertLogs();
        IntegrationLog__c logs = [SELECT Endpoint__c FROM IntegrationLog__c];
        Test.stopTest();

        System.assertEquals(sessionId, 'SESSION_ID_REMOVED');
        System.assertEquals('callout:SalesforceLoginCallout/', logs.Endpoint__c);
    }

    @IsTest
    static void CreateContactCallout() {
        String responseBody = '<soapenv:Body>' +
                '<createResponse>' +
                '<result>' +
                '<id>0031k00000o81XOAAY</id>' +
                '<success>true</success>' +
                '</result>' +
                '</createResponse>' +
                '</soapenv:Body>';
        MockFactory mock = new MockFactory(200, 'OK', responseBody, new Map<String, String>());
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        String Id = (String) CalloutExecutor.execute(new CreateContactCallout('Test Contact'));
        CalloutExecutor.insertLogs();
        IntegrationLog__c logs = [SELECT Endpoint__c FROM IntegrationLog__c];
        Test.stopTest();

        System.assertEquals(Id, '0031k00000o81XOAAY');
        System.assertEquals('callout:SoapService1/', logs.Endpoint__c);
    }

    @IsTest
    static void testInsertLogNegative() {
        String result = '';
        try {
            CalloutExecutor.insertLogs();
        } catch (Exception e) {
            result = e.getMessage();
        }
        System.assert(result.contains('Empty Logs List'), 'Logs are not empty');
    }

}