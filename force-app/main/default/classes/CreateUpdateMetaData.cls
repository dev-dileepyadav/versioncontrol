// Thsi interface is opetional
public  class CreateUpdateMetaData implements Metadata.DeployCallback {
   // this is optional
    public void handleResult(Metadata.DeployResult result, Metadata.DeployCallbackContext context) {
        if (result.status == Metadata.DeployStatus.Succeeded) {
            System.debug(' success : '+ result);
        } else {
            System.debug(' fail : '+ result);
        }
    }

    public static void createUpdateMetaData(String fullName, String label,Map<String,Object> fieldWithValueMap){
        MetaData.customMetaData customMetaData = new MetaData.customMetaData();
//Salesforce_Config.SalesforceToken
        customMetaData.fullName = fullName; // API Name - custom meta data record it should be like CustomMetaData.API name without space object Name is custom meta Data 
        customMetaData.label = label;

        for(String key : fieldWithValueMap.keySet()){
            Metadata.customMetaDataValue customField = new Metadata.customMetaDataValue();
            //Prepare the field Value       
            customField.field = key;
            customField.value = fieldWithValueMap.get(key);

            customMetaData.values.add(customField);
        }

        Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
        mdContainer.addMetadata(customMetaData);
        
        CreateUpdateMetaData callBAck = new CreateUpdateMetaData();
        Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, callBack);

    }
}