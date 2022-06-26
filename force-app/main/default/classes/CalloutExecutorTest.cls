/**
 * Created by Sergey Krivorotov.
 *
 * Contains test logic for CalloutExecutor.
 */

@IsTest
private class CalloutExecutorTest {

    @IsTest
    static void testExecute() {
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
        MockFactory mock = new MockFactory(200, 'OK', responseBody, new Map<String,String>());
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        Map<String, RatesCallout.Rate> rates = (Map<String, RatesCallout.Rate>)CalloutExecutor.execute(new RatesCallout('usd'));
        CalloutExecutor.insertLogs();
        IntegrationLog__c logs = [SELECT Endpoint__c FROM IntegrationLog__c];
        Test.stopTest();

        System.assertEquals('EUR', rates.get('eur').code);
        System.assertEquals(978, rates.get('eur').numericCode);
        System.assertNotEquals('USD', rates.get('eur').alphaCode);
        System.assertEquals('callout:RatesService1/daily/usd.json', logs.Endpoint__c);
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