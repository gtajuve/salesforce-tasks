/**
 * PersonAccountHandler class
 * @author CloudMyBiz (r)
 * @date 8/19/19
 * @description
 * @group 
 */

public with sharing class PersonAccountHandler {

	public static PersonAccountService pas = new PersonAccountService();
	public static AppSettings appSettings = new AppSettings();
	public static FieldsPermission fieldsPermission = new FieldsPermission();

	public static void handleTrigger(List<Person_Account__c> newPersonAccounts, List<Person_Account__c> oldPersonAccounts,Map<Id, Person_Account__c> oldMap, System.TriggerOperation triggerEvent) {

		switch on triggerEvent {

			when AFTER_INSERT {

			}
			when AFTER_UPDATE {

			}
			when BEFORE_INSERT {

			}
			when BEFORE_UPDATE {
				if (appSettings.getEnableSavePersonAccountOldNames()) {
					Set<String> updateableFields = fieldsPermission.updateablePersonAccountFields;
					if ( updateableFields.size() > 0){
						for ( Person_Account__c personAccount : newPersonAccounts){
							pas.copyPersonAccountOldName(personAccount,oldMap.get(personAccount.Id),updateableFields);
						}
					}

				}
			}
			when AFTER_DELETE {

			}
			when else {

			}
		}

	}
}