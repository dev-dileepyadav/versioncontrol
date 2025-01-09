public with sharing class AWSS3Manager {
    
    public static void createBucket(String bucketName, String recordId, String region){
        bucketName = bucketName.toLowerCase().replaceAll(' ','-') + '-'+ recordId.toLowerCase();
        System.debug('Bucket Name '+ bucketName);

        HttpRequest req = new HttpRequest();
        req.setEndPoint('callout:AWSS3Cred'+'/'+bucketName);

        // Whenever we create any bucket in AWS we use PUT method

        req.setMethod('PUT');

        // If you want to create bucket in default reagion we don't need to add body in the request.

        String requestBody = '<?xml version="1.0" encoding="UTF-8"?>'+
        '<CreateBucketConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01">'+
        '<LocationConstraint>'+region+'</LocationConstraint>'+
        '</CreateBucketConfiguration>';

        if(String.isNotBlank(region) && !region.equalsIgnoreCase('us-east-1')){
            req.setBody(requestBody);
        }


        try{
            HttpResponse res = (new http().send(req));
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201){

                createFolderInstanceBucket(bucketName,'Opportunity');
                createFolderInstanceBucket(bucketName,'Orders');
                // Update the Account
                Account acc = new Account(Id = recordId, S3BucketName__c = bucketName);
                update acc;
            }else {
                
            }
        }catch(System.exception ex){
            
        }
    }

    public static void createFolderInstanceBucket(String bucketName, String folderName){

        //bucketName = bucketName.toLowerCase().replaceAll(' ','-') + '-'+ recordId.toLowerCase();
        

        HttpRequest req = new HttpRequest();
        // When we are creating the folder inside the bucket we need to add additional '/' symbol before folder name if we not add '/' it will consider as file

        req.setEndPoint('callout:AWSS3Cred'+'/'+bucketName+'/'+ EncodingUtil.urlEncode(folderName,'UTF-8')+'/');

        // Whenever we create any bucket in AWS we use PUT method

        req.setMethod('PUT');
        // If we will not provide the content lenth header we will get the error of content lenght
        req.setHeader('Content-Length','0');


        try{
            HttpResponse res = (new http().send(req));
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201){
               
                
            }else {

            }
        }catch(System.exception ex){
            
        }
    }


    public static void createBucketFolderInsideBucketFolder(String bucketName, String folderPath, String folderName){
        //Whtaever file we upload in the salesforce is stored in the contentversion object so we can use the query to get the file id.
        //SELECT Id,Title,FileExtension,VersionData FROM ContentVersion
        HttpRequest req = new HttpRequest();

        req.setEndPoint('callout:AWSS3Cred'+'/'+bucketName+'/'+ EncodingUtil.urlEncode(folderPath,'UTF-8')+'/'+ EncodingUtil.urlEncode(folderName,'UTF-8')+'/');
        req.setMethod('PUT');
        req.setHeader('Content-Length','0');
        try{
            HttpResponse res = (new http().send(req));
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201){
               
                
            }else {

            }
        }catch(System.exception ex){
            
        }
    }

    public static void uploadFile(String recordId,String bucketPath){
        // VersionData store the file
        ContentVersion version = [SELECT Id,FileType,FileExtension,VersionData FROM ContentVersion WHERE Id =: recordId];
        HttpRequest req = new HttpRequest();

        req.setEndPoint('callout:AWSS3Cred'+'/'+EncodingUtil.urlEncode(bucketPath,'UTF-8')+'/'+ version.Title+'.'+version.FileExtension);
        req.setMethod('PUT');
        req.setBodyAsBlob(version.VersionData);
        req.setHeader('Content-Length','0');


        try{
            HttpResponse res = (new http().send(req));
            if(res.getStatusCode() == 200 || res.getStatusCode() == 201){
               
                
            }else {

            }
        }catch(System.exception ex){
            
        }

    }
}