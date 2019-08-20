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

	static testMethod void testBehaviorPositive() {

		User u = TestFactory.generateUser('system administrator');
		System.runAs(u) {

			Person_Account__c personAccount = new Person_Account__c(First_Name__c = 'Test', Last_Name__c = 'Test');
			insert personAccount;
			personAccount.First_Name__c = 'Test01';
			personAccount.Last_Name__c = 'Test01';
			Test.startTest();
			update personAccount;
			Test.stopTest();

			List<Person_Account__c> personAccounts = [SELECT Old_First_Name__c,Old_Last_Name__c FROM Person_Account__c WHERE First_Name__c = 'Test01' LIMIT 1];

			System.assertEquals('Test', personAccounts[0].Old_First_Name__c);
			System.assertEquals('Test', personAccounts[0].Old_Last_Name__c);
		}

	}
	static testMethod void testBehaviorNegative() {

		User u = TestFactory.generateUser('standard user');
		System.runAs(u){
			Person_Account__c personAccount = new Person_Account__c(First_Name__c = 'Test', Last_Name__c = 'Test');
			insert personAccount;
			personAccount.First_Name__c = 'Test01';
			personAccount.Last_Name__c = 'Test01';
			Test.startTest();

			update personAccount;
			Test.stopTest();

			List<Person_Account__c> personAccounts = [SELECT Old_First_Name__c,Old_Last_Name__c FROM Person_Account__c WHERE First_Name__c = 'Test01' LIMIT 1];
			System.assertEquals(null, personAccounts[0].Old_First_Name__c);
		}



//			System.assertEquals(null,personAccounts[0].Old_Last_Name__c);



	}

	@future
	public static void changeFieldPermission(){
		PermissionSet ps = [SELECT id FROM PermissionSet WHERE ProfileId = :UserInfo.getProfileId() LIMIT 1];
		List<FieldPermissions> fieldPermissions = ([SELECT id,PermissionsEdit FROM FieldPermissions WHERE ParentId = :ps.Id AND Field = 'Person_Account__c.Old_First_Name__c' LIMIT 1]);
		if (fieldPermissions.size() == 0 ) {
			FieldPermissions fieldPermission = new FieldPermissions(ParentId = ps.Id, Field = 'Person_Account__c.Old_First_Name__c', SobjectType = 'Person_Account__c', PermissionsRead = true, PermissionsEdit = false);

			insert fieldPermission;
		}else if(fieldPermissions[0].PermissionsEdit ){
			fieldPermissions[0].PermissionsEdit = false;
			update fieldPermissions[0];
		}
	}
}