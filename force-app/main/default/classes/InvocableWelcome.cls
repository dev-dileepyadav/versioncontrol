public class InvocableWelcome {

    @invocablemethod(label='welcome message' description = 'this is welcome meaasge method' category = 'Mesage')
    public static List<String> welcomeMessage(List<String> name){
        String myName = name.get(0);
        List<String> listOfString = new List<String>();
        listOfString.add('Hi'+myName+'Hello I am comming from invocable method');
        return listOfString;
    }
}