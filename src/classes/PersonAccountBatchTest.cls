/**
 * PersonAccountBatchTest class
 * @author CloudMyBiz (r)
 * @date 8/13/19
 * @description
 * @group 
 */

@IsTest
private class PersonAccountBatchTest {

	@testSetup
	static void setupMethod() {
		List<Contact> contacts = new List<Contact>();
		for (Integer i=0;i<10;i++) {
			contacts.add(new Contact(FirstName = 'Test',LastName = 'Test'+ i));
		}
		insert contacts;
	}

	static testMethod void testBehavior() {
			Test.startTest();
			PersonAccountBatch pab = new PersonAccountBatch();
			Id batchId = Database.executeBatch(pab);
			Test.stopTest();
			// after the testing stops, assert records were updated properly
			System.assertEquals(10, [select count() from Person_Account__c where First_Name__c = 'Test' ]);
	}
}