/**
 * Created by Sergey Krivorotov.
 */

public with sharing class CalloutExecutor {

    public static Object execute(Callout instance) {
        Http http = new Http();
        HttpRequest request = instance.buildHttpRequest();
        HttpResponse response = http.send(request);
        //add logResult
        return instance.parseResponse(response.getBody());
    }

}