/**
 * Created by Sergey Krivorotov.
 *
 * Contains logic for creating SObjects of different type(with fields and values).
 */

public with sharing class CalloutSFCrerateSObject extends Callout {

    private String sessionId;
    private String sObjectApiName;
    private Map<String, String> fieldsAndValues;

    public CalloutSFCrerateSObject(String sessionId, String sObjectApiName, Map<String, String> fieldsAndValues) {
        this.sessionId = sessionId;
        this.sObjectApiName = sObjectApiName;
        this.fieldsAndValues = fieldsAndValues;
        endpoint = 'callout:SoapService1/';
        method = CalloutMethodConstants.POST_METHOD;
        headers = new Map<String, String>{
                'Content-Type' => 'text/xml;charset=UTF-8',
                'SOAPAction' => '""'
        };
    }

    public override String buildRequestBody() {
        return '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"' +
                ' xmlns:urn="urn:enterprise.soap.sforce.com" xmlns:urn1="urn:sobject.enterprise.soap.sforce.com">' +
                '<soapenv:Header>' +
                '<urn:SessionHeader>' +
                '<urn:sessionId>' + sessionId + '</urn:sessionId>' +
                '</urn:SessionHeader>' +
                '</soapenv:Header>' +
                '<soapenv:Body>' +
                '<urn:create>' +
                '<urn:sObjects xsi:type="urn1:' + sObjectApiName + '" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' +
                buildFiledValueXmlString(fieldsAndValues) +
                '</urn:sObjects>' +
                '</urn:create>' +
                '</soapenv:Body>' +
                '</soapenv:Envelope>';
    }

    public override Object parseResponse(String response) {
        return response.substring(response.indexOf('<id>') + '<Id>'.length(), response.indexOf('</id>'));
    }

    protected override Type getType() {
        return CalloutSFCrerateSObject.class;
    }

    private String buildFiledValueXmlString(Map <String, String> fieldsAndValues) {
        String fieldsXml = '';
        for (String field : fieldsAndValues.keySet()) {
            fieldsXml = fieldsXml + '<' + field + '>' + fieldsAndValues.get(field) + '</' + field + '>';
        }
        return fieldsXml;
    }

}