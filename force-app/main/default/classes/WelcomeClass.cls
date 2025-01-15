public class WelcomeClass {

    @invocablemethod(
        label = 'Display welcome message'
    description = 'This method will show the welcome method'
    category = 'invocable methods')
    public static List<String> welcomeMessage(List<String> name){
        String na = name.get(0);
        List<String> welcomeMessage = new List<String>();
        welcomeMessage.add(na+ ' Welcome to the flow bootcamp. I am comming from apex invocable class');
        return welcomeMessage;
    }
}