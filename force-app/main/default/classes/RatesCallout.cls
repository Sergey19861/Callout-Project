/**
 * Created by Sergey Krivorotov.
 */

public with sharing class RatesCallout extends Callout{

    public RatesCallout(String endpoint, String method, String headerKey, String headerValue) {
        this.endpoint = endpoint;
        this.method = method;
        this.headerKey = headerKey;
        this.headerValue = headerValue;
    }

    public override String buildRequestBody() {
        return null;
    }

    public override Object parseResponse(String response) {
        return null;
    }
}