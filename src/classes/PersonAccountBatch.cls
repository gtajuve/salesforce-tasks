global with sharing class PersonAccountBatch implements Database.Batchable<sObject> {
	global String query = 'SELECT Id,Name,FirstName,LastName,MailingAddress,OtherAddress FROM Contact WHERE Id NOT IN (SELECT Contact__c FROM Person_Account__c)';
	@TestVisible
	global PersonAccountService pas = new PersonAccountService();
	global PersonAccountBatch() {
	}
	global Database.QueryLocator start(Database.BatchableContext bc) {
			return Database.getQueryLocator(query);

	}
	global void execute(Database.BatchableContext bc, List<Contact> scope) {
		pas.createPersonAccount( scope);
	}
	global void finish(Database.BatchableContext bc) {
	}


}