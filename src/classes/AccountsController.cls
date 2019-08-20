/**
 * AccountsController class
 * @author CloudMyBiz (r)
 * @date 6/24/19
 * @description
 * @group 
 */

public with sharing class AccountsController {

    @AuraEnabled
    public static List <Account> getAccounts() {
        return [SELECT Id, Name, Type, Phone FROM Account ORDER BY Name ASC];
    }

    @AuraEnabled
    public static void deleteAccount(Account account) {
        delete account;
    }

    @AuraEnabled
    public static String fetchUser(){
        return UserInfo.getName();
    }

}