/**
 * Created by Sergey Krivorotov.
 *
 *Designed to login in Salesforce Scratch org and get sessionId.
 */

public with sharing class SalesforceLoginCallout extends Callout {

    public SalesforceLoginCallout(String userName, String password) {
        secretMap = new Map<String, String>{
                'USER_NAME' => userName,
                'PASSWORD' => password
        };
        endpoint = 'callout:SalesforceLoginCallout/';
        method = CalloutMethodConstants.POST_METHOD;
        headers = new Map<String, String>{
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
                '<urn:username>{!USER_NAME}</urn:username>' +
                '<urn:password>{!PASSWORD}</urn:password>' +
                '</urn:login>' +
                '</soapenv:Body>' +
                '</soapenv:Envelope>';
    }

    public override Object parseResponse(String response) {
        String sessionId = response.substring(response.indexOf('<sessionId>') + '<sessionId>'.length(), response.indexOf('</sessionId>'));
        log.Response__c = log.Response__c.replace(sessionId, 'SESSION_ID_REMOVED');
        return sessionId;
    }

    protected override Type getType() {
        return SalesforceLoginCallout.class;
    }
}