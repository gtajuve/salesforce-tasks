global class PersonAccountBatch implements Database.Batchable<sObject> {
	global String query = 'SELECT Id,Name,FirstName,LastName,MailingAddress,OtherAddress FROM Contact WHERE Id NOT IN (SELECT Contact__c FROM Person_Account__c)';
	global PersonAccountBatch() {
	}
	global Database.QueryLocator start(Database.BatchableContext bc) {
		return Database.getQueryLocator(query);
	}
	global void execute(Database.BatchableContext bc, List<Contact> scope) {
		List<Person_Account__c> perAccs = new List<Person_Account__c>();
		for (Contact cont : scope){
			Person_Account__c perAcc = new Person_Account__c();
			perAcc.Contact__c = cont.Id;
			perAcc.Name = cont.Name;
			perAcc.First_Name__c = cont.FirstName;
			perAcc.Last_Name__c = cont.LastName;
			perAcc.Mailing_Address__c = convertAddressObjectToString(cont.MailingAddress);
			perAcc.Other_Address__c = convertAddressObjectToString(cont.OtherAddress);
			perAccs.add(perAcc);
		}
	insert perAccs;
	}
	global void finish(Database.BatchableContext bc) {
	}

	private String convertAddressObjectToString(Address address){
		if (address == null){
			return null;
		}
		return  (address.country != null?address.country  + ',':'') + (address.city != null?address.city  + ',':'') + (address.state != null?address.state  + ',':'') + (address.street != null?address.street  + ',':'') + (address.postalCode != null?address.postalCode :'');
	}
}