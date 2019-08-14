/**
 * AppSettings class
 * @author CloudMyBiz (r)
 * @date 8/13/19
 * @description
 * @group 
 */

public class AppSettings {
	@TestVisible
	private App_Settings__c appSettings;

	public AppSettings() {
		List<App_Settings__c> settings = [
				SELECT 	Add_Person_Account__c,Copy_old_names__c
				FROM App_Settings__c
				LIMIT 1
		];

		if (!settings.isEmpty()) {
			appSettings = settings[0];
		}
	}

	public Boolean getEnableAddPersonAccount() {
		return appSettings.Add_Person_Account__c;
	}

	public Boolean getEnableSavePersonAccountOldNames() {
		return appSettings.Copy_old_names__c;
	}


}