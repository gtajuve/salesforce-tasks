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
		App_Settings__c setting = new App_Settings__c();
		setting.Add_Person_Account__c = false;
		insert setting;
		List<Contact> contacts = new List<Contact>();
		for (Integer i=0;i<5;i++) {
			contacts.add(new Contact(FirstName = 'Test22',LastName = 'Test'+ i));
		}
		insert contacts;

	}

	static testMethod void testBehaviorPositive() {
		MockSObjectsPermission mockSObjectsPermission = new MockSObjectsPermission(true,true);
		ObjectPermission objectPermission = (ObjectPermission)Test.createStub(ObjectPermission.class, mockSObjectsPermission);

		Test.startTest();
		PersonAccountBatch pab = new PersonAccountBatch();
		pab.pas.objectPermission = objectPermission;
		Id batchId = Database.executeBatch(pab);
		Test.stopTest();
		// after the testing stops, assert records were updated properly
		System.assertEquals(5, [SELECT COUNT() FROM Person_Account__c ]);
		List<Person_Account__c> personAccounts = [SELECT First_Name__c,Last_Name__c FROM Person_Account__c ];
		Integer i = 0 ;
		for (Person_Account__c pa : personAccounts){
			System.assertEquals('Test22', pa.First_Name__c);
			System.assertEquals('Test'+i, pa.Last_Name__c);
			i++;
		}

	}
	static testMethod void testBehaviorNegative() {
		MockSObjectsPermission mockSObjectsPermission = new MockSObjectsPermission(false,true);
		ObjectPermission objectPermission = (ObjectPermission)Test.createStub(ObjectPermission.class, mockSObjectsPermission);

		Test.startTest();
		PersonAccountBatch pab = new PersonAccountBatch();
		pab.pas.objectPermission = objectPermission;
		Id batchId = Database.executeBatch(pab);
		Test.stopTest();
		// after the testing stops, assert records were updated properly
		System.assertEquals(0, [SELECT COUNT() FROM Person_Account__c ]);

	}
}
