/**
 * InsertPersonAccountTrigger class
 * @author CloudMyBiz (r)
 * @date 8/13/19
 * @description Trigger for Contact. Follows the One Trigger Per Object design pattern, which allows for the control of execution order and recursion
 * @group Triggers
 */
trigger InsertPersonAccountTrigger on Contact (after insert) {

	AppSettings appSettings = new AppSettings();

	if (appSettings.getEnableAddPersonAccount()) {
		List<Person_Account__c> personAccounts = new List<Person_Account__c>();
		for( Contact contact : Trigger.new){
			Person_Account__c perAcc = new Person_Account__c();
			perAcc.Contact__c = contact.Id;
			perAcc.Name = contact.Name;
			perAcc.First_Name__c = contact.FirstName;
			perAcc.Last_Name__c = contact.LastName;
			personAccounts.add(perAcc);
		}
		insert personAccounts;
	}
}

