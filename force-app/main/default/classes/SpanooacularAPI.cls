public class SpanooacularAPI {

    private static final String API = 'https://api.spoonacular.com';
    private static final String API_KEY = '60704c832e2f45e79336b558256eeaf7';
    
    public static String getRandomRecipe(){
        
    http ht = new http();
    httpRequest request = new httpRequest();
    request.setEndPoint(API+'/recipes/random?apiKey='+API_KEY);
    request.setmethod('GET');
    httpresponse responce = ht.send(request);
    System.debug('Code --> ' + responce.getstatusCode());
    if(responce.getstatuscode()== 200){
    return responce.getBody();
}
        return '';
    }
    
   
    
    public static String getRecipe(String receipID){
        
    http ht = new http();
    httpRequest request = new httpRequest();
    request.setEndPoint(API+'/recipes/'+receipID+'information?apiKey='+API_KEY);
    request.setmethod('GET');
    httpresponse responce = ht.send(request);
    System.debug('Code --> ' + responce.getstatusCode());
    if(responce.getstatuscode()== 200){
    System.debug('Body -->' + responce.getbody());
        return responce.getBody();
} return '';
    }
    
     public static String getRecipeByIngridents(String ingredients){
        
    http ht = new http();
    httpRequest request = new httpRequest();
    request.setEndPoint(API+'/recipes/findByIngredients?apiKey='+API_KEY+'&ingredients='+ingredients);
    request.setmethod('GET');
    httpresponse responce = ht.send(request);
    System.debug('Code --> ' + responce.getstatusCode());
    if(responce.getstatuscode()== 200){
    System.debug('Body -->' + responce.getbody());
        return responce.getBody();
}return '';
    }
}