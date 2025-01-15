import { LightningElement } from 'lwc';
import isGuest from '@salesforce/user/isGuest';
import basePath from "@salesforce/community/basePath";

export default class LogOutButton extends LightningElement {

    get isGuest(){
        return isGuest;
    }

    get logOutUrl(){
        const siteprefix = basePath.replace(/\/s$/i,"");
        return siteprefix+'/secur/logout.jsp';
    }
    
}