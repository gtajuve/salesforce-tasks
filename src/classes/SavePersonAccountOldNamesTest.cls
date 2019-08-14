/**
 * SavePersonAccountOldNamesTest class
 * @author CloudMyBiz (r)
 * @date 8/14/19
 * @description
 * @group 
 */

@IsTest
private class SavePersonAccountOldNamesTest {

	@testSetup static void setupMethod() {
		App_Settings__c setting = new App_Settings__c();
		setting.Copy_old_names__c = true;
		insert setting;
	}

	static testMethod void testBehavior() {
		Person_Account__c personAccount = new Person_Account__c(First_Name__c = 'Test',Last_Name__c = 'Test');
		insert personAccount;
		personAccount.First_Name__c = 'Test01';
		personAccount.Last_Name__c = 'Test01';
		Test.startTest();
		update personAccount;
		Test.stopTest();

		List<Person_Account__c> personAccounts = [SELECT Old_First_Name__c,Old_Last_Name__c FROM Person_Account__c WHERE First_Name__c = 'Test01' LIMIT 1];

		System.assertEquals('Test',personAccounts[0].Old_First_Name__c);
		System.assertEquals('Test',personAccounts[0].Old_Last_Name__c);

	}
}