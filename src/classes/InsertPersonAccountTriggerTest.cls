/**
 * InsertPersonAccountTriggerTest class
 * @author CloudMyBiz (r)
 * @date 8/14/19
 * @description
 * @group 
 */

@IsTest
private class InsertPersonAccountTriggerTest {

	@testSetup static void setupMethod() {
		App_Settings__c setting = new App_Settings__c();
		setting.Add_Person_Account__c = true;
		insert setting;
	}

	static testMethod void testBehavior() {
		List<Contact> contacts = new List<Contact>();
		for (Integer i=0;i<10;i++) {
			contacts.add(new Contact(FirstName = 'Test',LastName = 'Test'+ i));
		}

		Test.startTest();
		insert contacts;
		Test.stopTest();
		// Verify
		// In this case the deletion should have been stopped by the trigger,
		// so verify that we got back an error.
		System.assertEquals(10,[SELECT count() FROM Person_Account__c WHERE First_Name__c = 'Test']);

	}
}