public class ApexCallout {

    
    public static Decimal convertCurrency(Decimal usd){
        Decimal INR = 0.0;
        
        http h = new http();
        httpRequest req = new httpRequest();
        req.setEndPoint('https://free.currconv.com/api/v7/convert?q=USD_INR&apikey=648a2f3baea82e0ba9df');
        req.setmethod('GET');
        httpResponse res = h.send(req);
        
        Map<String,object> jsonBody = (map<String,object>)JSON.deserializeUntyped(res.getBody());
        System.debug(jsonBody);
        //Map<String,object> mMap = (map<String,object>) JSONBody.get('results');
        //Map<String,object> mMap2 = (map<String,object>) mMap.get('USD_INR');
        
        //Decimal convertRate = (Decimal)mMap2.get('val');
        //inr = usd * convertRate;
        return inr;
    }
}