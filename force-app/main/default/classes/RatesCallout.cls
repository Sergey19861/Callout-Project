/**
 * Created by Sergey Krivorotov.
 */

public with sharing class RatesCallout extends Callout {

    public RatesCallout(String baseCurrency) {
        this.endpoint = 'callout:RatesService1/daily/' + baseCurrency + '.json';
        this.method = HttpMethod.GET;
    }

    public override String buildRequestBody() {
        //do not use
        return null;
    }

    public override Object parseResponse(String response) {
        Map<String, RatesCallout.Rate> ratesMap = (Map<String, RatesCallout.Rate>) JSON.deserialize(response, Map<String, RatesCallout.Rate>.class);
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
        return RatesCallout.class;
    }
}