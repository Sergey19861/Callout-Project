/**
 * Created by Sergey Krivorotov.
 *
 * Designed to integrate org with www.floatrates.com
 */

public with sharing class CalloutRates extends Callout {

    public CalloutRates(String baseCurrency) {
        this.endpoint = 'callout:RatesService1/daily/' + baseCurrency + '.json';
        this.method = CalloutMethodConstants.GET_METHOD;
    }

    public override String buildRequestBody() {
        //do not use
        return null;
    }

    public override Object parseResponse(String response) {
        Map<String, CalloutRates.Rate> ratesMap = (Map<String, CalloutRates.Rate>) JSON.deserialize(response, Map<String, CalloutRates.Rate>.class);
        return ratesMap;
    }

    public class Rate {
        public String code;
        public String alphaCode;
        public Integer numericCode;
        public String name;
        public Decimal rate;
        public String currentDate;
        public Decimal inverseRate;
    }

    protected override Type getType() {
        return CalloutRates.class;
    }

}