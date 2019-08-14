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
        System.debug(UserInfo.getUserId());
        return [SELECT Id, Name, Type, Phone FROM Account ORDER BY Name ASC];
    }

    @AuraEnabled
    public static void deleteAccount(Account account) {
        System.debug(account);
        delete account;
    }

//    @AuraEnabled
//    public static List<String> getAccountFieldList() {
//        List<String> fieldsName = new List<String>();
//
//        Map<String, Schema.SObjectField> mapField = Schema.SObjectType.Account.fields.getMap();
//        for(String fieldName : mapField.keySet()) {
//            if(mapField.get(fieldName).getDescribe().isUpdateable()) {
//                String upperString = fieldName.substring(0,1).toUpperCase() + fieldName.substring(1).toLowerCase();
//                fieldsName.add(upperString);
//            }
//        }
//
//        return fieldsName;
//    }

    @AuraEnabled
    public static String fetchUser(){
        return UserInfo.getName();
    }

}