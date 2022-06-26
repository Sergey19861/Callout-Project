/**
 * Created by Sergey Krivorotov.
 *
 *Desined to get sessionId.
 */

public with sharing class SalesforceLoginCallout extends Callout{

    private String userName;
    private String password;

    public SalesforceLoginCallout(String userName, String password) {
        this.userName = userName;
        this.password = password;
        endpoint = 'callout:SalesforceLoginCallout/';
        method = CalloutMethodConstatnts.POST_METHOD;
        headers = new Map<String, String> {
                'Content-Type' => 'text/xml;charset=UTF-8',
                'SOAPAction' => '""'
        };
    }

    public override String buildRequestBody() {
        return '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:enterprise.soap.sforce.com">' +
        '<soapenv:Header>' +
        '</soapenv:Header>' +
        '<soapenv:Body>' +
        '<urn:login>' +
        '<urn:username>' + userName + '</urn:username>' +
        '<urn:password>' + password + '</urn:password>' +
        '</urn:login>' +
        '</soapenv:Body>' +
        '</soapenv:Envelope>';
    }

    public override Object parseResponse(String response) {
        System.debug('Response: ' + response);
        Pattern sessionIdPattern = Pattern.compile('(\b<sessionId>\b)');
        Matcher sessionIdMatcher = sessionIdPattern.matcher(response);
        System.debug('Matcher: ' + sessionIdMatcher);
        System.debug('Result: ' + sessionIdMatcher.matches());
        return null;
    }

    protected override Type getType() {
        return SalesforceLoginCallout.class;
    }
}