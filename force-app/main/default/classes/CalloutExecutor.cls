/**
 * Created by Sergey Krivorotov.
 */

public with sharing class CalloutExecutor {

    public static Object execute(Callout instance) {
        HttpRequest request = instance.buildHttpRequest();
        HttpResponse response = instance.countCalloutTime(request);
        IntegrationLog log = instance.logCallout(request, response);

        System.debug(log);
        return instance.parseResponse(response.getBody());
    }

}