public class AddnameListVF {
    
    public List<String> name{get;set;}
    public String values{get;set;}
    
    public AddnameListVF(){
        name = new List<String>{'Dileep', 'Manish'};
    }
    
    public void saveIt(){
        name.add(values);
        
    }
    
    public void remove(){
        name.remove(0);
    }

}