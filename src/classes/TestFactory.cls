@isTest
public class TestFactory {

	public static User generateUser(String profileName){
		UserRole userRole = new UserRole(DeveloperName = 'TestingTeam', Name = 'Testing Team');
		insert userRole;
		Id profileId = [SELECT Id FROM Profile WHERE Name = :profileName].Id;
		User u = new User(
				ProfileId = profileId,
				LastName = 'last',
				Email = 'Cpt.Awesome@awesomesauce.com',
				Username = 'Cpt.Awesome@awesomesauce.com',
				CompanyName = 'Testing Co',
				Title = 'Captian',
				Alias = 'alias',
				TimeZoneSidKey = 'America/Los_Angeles',
				EmailEncodingKey = 'UTF-8',
				LanguageLocaleKey = 'en_US',
				LocaleSidKey = 'en_US',
				UserRoleId = userRole.Id
		);
		insert u;

		PermissionSet ps = [SELECT id FROM PermissionSet WHERE ProfileId = :profileId LIMIT 1];
		List<FieldPermissions> fieldPermissions = ([SELECT id,PermissionsEdit FROM FieldPermissions WHERE ParentId = :ps.Id AND Field = 'Person_Account__c.Old_First_Name__c' LIMIT 1]);
		if (fieldPermissions.size() == 0 ) {
			FieldPermissions fieldPermission = new FieldPermissions(ParentId = ps.Id, Field = 'Person_Account__c.Old_First_Name__c', SobjectType = 'Person_Account__c', PermissionsRead = true, PermissionsEdit = true);

			insert fieldPermission;
		}else if(!fieldPermissions[0].PermissionsEdit ){
			fieldPermissions[0].PermissionsEdit = true;
			update fieldPermissions[0];
		}
		return u;


	}
}