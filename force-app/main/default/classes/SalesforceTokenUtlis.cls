public with sharing class SalesforceTokenUtlis {
    
    public static PageReference getAuthCode(){
        Salesforce_Config__mdt config = Salesforce_Config__mdt.getInstance('SalesforceToken');
        System.debug('Config '+config);
        if(config != null){
            String orgURL = config.Enviroment__c == 'Production' ? 'https://login.salesforce.com' : 'https://test.salesforce.com';
            System.debug('Org URL '+orgURL);
            String redirectURI = URL.getOrgDomainURL().toExternalForm()+'/apex/'+config.page_name__c;
            System.debug('Redirect URI '+redirectURI);
            String authroizeURL = orgURL+config.auth_url__c+'?client_id='+config.client_id__c+'&redirect_uri='+redirectURI+'&response_type=code';
            System.debug('AUth URL '+authroizeURL);
            return new PageReference(authroizeURL);

        }else {
            return null;
        }
    }

    public static void getAccessToken(){

        String code = ApexPages.currentPage().getParameters().get('code');
        System.debug('Code '+code);
        Salesforce_Config__mdt config = Salesforce_Config__mdt.getInstance('SalesforceToken');
        String redirectURI = URL.getOrgDomainURL().toExternalForm()+'/apex/'+config.page_name__c;
        
        System.debug('Config '+config);
        if(config != null){
            String orgURL = config.Enviroment__c == 'Production' ? 'https://login.salesforce.com/' : 'https://test.salesforce.com/';
            System.debug('Org URL '+orgURL);
            String tokenURL = orgURL+config.token_url__c;
            System.debug('Token URL ->'+tokenURL);

            String requestBody = 'code='+code+'grant_type=authorization_code'+'&client_id='+config.client_id__c+'&client_secret='+config.client_secret__c+'&redirect_uri='+redirectURI;
        HttpRequest req = new HttpRequest();
        req.setEndPoint(tokenURL);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setHeader('Accept', 'application/json');
        req.setBody(requestBody);
        Http http = new Http();
        try{
            HttpResponse res = http.send(req);
            if(res.getStatusCode() == 201){
                SalesforceTokenWrapper wrapper = (SalesforceTokenWrapper)JSON.deserialize(res.getBody(), SalesforceTokenWrapper.class);
                String fullName = 'Salesforce_Config';
                String label = 'Salesforce_Config.SalesforceToken';
                Map<String,Object> fieldWithValueMap = new Map<String,Object>();
                fieldWithValueMap.put('access_token__c',wrapper.access_token);
                fieldWithValueMap.put('expires_in_time__c',System.now().addHours(2));
                fieldWithValueMap.put('instance_url__c',wrapper.instance_url);
                fieldWithValueMap.put('refresh_token__c',wrapper.refresh_token);
                fieldWithValueMap.put('scope__c',wrapper.scope);
                CreateUpdateMetaData.createUpdateMetaData(fullName,label,fieldWithValueMap);
                ApexPages.addMessage(new ApexPages.message(ApexPAges.severity.CONFIRM,'Successful!'));
                System.debug(res.getBody());
            }else{
                ApexPages.addMessage(new ApexPages.message(ApexPAges.severity.ERROR,res.getBody()));
            }
        }catch(System.calloutException ex){
            System.debug(ex);
            ApexPages.addMessage(new ApexPages.message(ApexPAges.severity.ERROR,ex.getMessage()));
        }
    }

    }
}