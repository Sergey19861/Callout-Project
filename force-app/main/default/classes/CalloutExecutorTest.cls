/**
 * Created by Sergey Krivorotov.
 */

@IsTest
private class CalloutExecutorTest {


    @IsTest
    static void testBehavior() {
        MockFactory mock = new MockFactory(200, 'OK', 'I found it!', new Map<String,String>());
        Test.setMock(HttpCalloutMock.class, mock);
        List<RatesCallout.Rate> result;
        RatesCallout newCallout = new RatesCallout('usd');
        Test.startTest();
//        result = ExternalSearch.googleIt('epic search');
        Test.stopTest();
 //       system.assertEquals('I found it!', result);
    }
}