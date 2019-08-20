/**
 * PersonAccountServiceTest class
 * @author CloudMyBiz (r)
 * @date 8/16/19
 * @description
 * @group 
 */

@IsTest
private class PersonAccountServiceTest {

	@testSetup static void setupMethod() {
		App_Settings__c setting = new App_Settings__c();
		setting.Add_Person_Account__c = false;
		insert setting;

	}

	static testMethod void testBehaviorGetAllFields() {
		MockFieldsPermission mockFieldsPermission = new MockFieldsPermission(new List<String>{
				'First_Name__c', 'Last_Name__c', 'Mailing_Address__c', 'Other_Address__c'
		}, new List<String>{
				'FirstName', 'LastName', 'MailingAddress', 'OtherAddress'
		},null);
		FieldsPermission fieldPermission = (FieldsPermission) Test.createStub(FieldsPermission.class, mockFieldsPermission);
		Contact contact = new Contact(FirstName = 'Test', LastName = 'Test', MailingCountry = 'Bulgaria' , OtherCountry = 'USA' );
		List<Contact> contacts = new List<Contact>();
		contacts.add(contact);
		PersonAccountService pas = new PersonAccountService();
		pas.fieldPermission = fieldPermission;
		Test.startTest();
		pas.createPersonAccount(contacts);
		Test.stopTest();
		List<Person_Account__c> pa = [SELECT First_Name__c,Last_Name__c,Mailing_Address__c,Other_Address__c FROM Person_Account__c];
		System.assertEquals('Test', pa[0].First_Name__c);
		System.assertEquals('Test', pa[0].Last_Name__c);

	}

	static testMethod void testBuildMissingFirstName() {
		MockFieldsPermission mockFieldsPermission = new MockFieldsPermission(new List<String>{
				'First_Name__c', 'Last_Name__c', 'Mailing_Address__c', 'Other_Address__c'
		}, new List<String>{
				'LastName', 'MailingAddress', 'OtherAddress'
		},null);
		FieldsPermission fieldPermission = (FieldsPermission) Test.createStub(FieldsPermission.class, mockFieldsPermission);
		Contact contact = new Contact(FirstName = 'Test', LastName = 'Test');
		List<Contact> contacts = new List<Contact>();
		contacts.add(contact);
		PersonAccountService pas = new PersonAccountService();
		pas.fieldPermission = fieldPermission;
		Test.startTest();
		pas.createPersonAccount(contacts);
		Test.stopTest();
		List<Person_Account__c> pa = [SELECT First_Name__c,Last_Name__c,Mailing_Address__c,Other_Address__c FROM Person_Account__c];
		System.assertEquals(null, pa[0].First_Name__c);
		System.assertEquals('Test', pa[0].Last_Name__c);

	}

	static testMethod void testBehaviorMissingLastName() {
		MockFieldsPermission mockFieldsPermission = new MockFieldsPermission(new List<String>{
				'First_Name__c', 'Last_Name__c', 'Mailing_Address__c', 'Other_Address__c'
		}, new List<String>{
				'FirstName', 'MailingAddress', 'OtherAddress'
		},null);
		FieldsPermission fieldPermission = (FieldsPermission) Test.createStub(FieldsPermission.class, mockFieldsPermission);
		Contact contact = new Contact(FirstName = 'Test', LastName = 'Test');
		PersonAccountService pas = new PersonAccountService();
		pas.fieldPermission = fieldPermission;
		List<Contact> contacts = new List<Contact>();
		contacts.add(contact);
		Test.startTest();
		pas.createPersonAccount(contacts);
		Test.stopTest();
		List<Person_Account__c> pa = [SELECT First_Name__c,Last_Name__c,Mailing_Address__c,Other_Address__c FROM Person_Account__c];
		System.assertEquals('Test', pa[0].First_Name__c);
		System.assertEquals(null, pa[0].Last_Name__c);

	}
}