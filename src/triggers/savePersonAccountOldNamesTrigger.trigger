/**
 * savePersonAccountOldNamesTrigger class
 * @author CloudMyBiz (r)
 * @date 8/14/19
 * @description Trigger for Person_Account__c. Follows the One Trigger Per Object design pattern, which allows for the control of execution order and recursion
 * @group Triggers
 */
trigger savePersonAccountOldNamesTrigger on Person_Account__c (before update) {

	AppSettings appSettings = new AppSettings();
	List<Person_Account__c> personAccounts = new List<Person_Account__c>();
	if (appSettings.getEnableSavePersonAccountOldNames()) {
		for( Id accountId : Trigger.newMap.keySet() )
		{
			if( Trigger.oldMap.get( accountId ).First_Name__c != Trigger.newMap.get( accountId ).First_Name__c )
			{
				Trigger.newMap.get( accountId ).Old_First_Name__c = Trigger.oldMap.get( accountId ).First_Name__c;
			}
			if( Trigger.oldMap.get( accountId ).Last_Name__c != Trigger.newMap.get( accountId ).Last_Name__c )
			{
				Trigger.newMap.get( accountId ).Old_Last_Name__c = Trigger.oldMap.get( accountId ).Last_Name__c;
			}
		}
	}
}