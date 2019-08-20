/**
 * PersonAccountsController class
 * @author CloudMyBiz (r)
 * @date 8/19/19
 * @description
 * @group 
 */

public with sharing class PersonAccountsController {

	@AuraEnabled
	public static List <Person_Account__c> getPersonAccounts() {
		return [SELECT Id, First_Name__c, Last_Name__c,Old_First_Name__c,Old_Last_Name__c FROM Person_Account__c ORDER BY Name ASC];
	}
}