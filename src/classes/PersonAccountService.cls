/**
 * PersonAccountService class
 * @author CloudMyBiz (r)
 * @date 8/15/19
 * @description
 * @group 
 */

public with sharing class PersonAccountService {
	@TestVisible
	public ObjectPermission objectPermission = new ObjectPermission();
	public FieldsPermission fieldPermission = new FieldsPermission();

	private Person_Account__c build(Contact cont) {
		Person_Account__c perAcc = new Person_Account__c();

		perAcc.Contact__c = cont.Id;
		perAcc.Name = cont.Name;
		if (this.fieldPermission.isAccessible('Contact','FirstName') && this.fieldPermission.isCreatable('Person_Account__c','First_Name__c')) {
			perAcc.First_Name__c = cont.FirstName;
		}
		if (this.fieldPermission.isAccessible('Contact','LastName') && this.fieldPermission.isCreatable('Person_Account__c','Last_Name__c')) {
			perAcc.Last_Name__c = cont.LastName;
		}

		if (this.fieldPermission.isAccessible('Contact','MailingAddress') && this.fieldPermission.isCreatable('Person_Account__c','Mailing_Address__c')) {
			perAcc.Mailing_Address__c = convertAddressObjectToString(cont.MailingAddress);
		}

		if (this.fieldPermission.isAccessible('Contact','OtherAddress') && this.fieldPermission.isCreatable('Person_Account__c','Other_Address__c')) {
			perAcc.Other_Address__c = convertAddressObjectToString(cont.OtherAddress);
		}
		return perAcc;
	}

	public void createPersonAccount(List<Contact> contacts){
		if( objectPermission.isContactAccessible()  && objectPermission.isPersonAccountCreatable()) {
			List<Person_Account__c> perAccs = new List<Person_Account__c>();
			for (Contact cont : contacts){
				perAccs.add( build(cont) );
			}
			insert perAccs;
		}

	}

	public void copyPersonAccountOldName(List<Person_Account__c> newPersonAccounts, Map<Id, Person_Account__c> oldMap){

		if (fieldPermission.isUpdateable('Person_Account__c','Old_First_Name__c') && fieldPermission.isAccessible('Person_Account__c','First_Name__c')) {
			for ( Person_Account__c personAccount : newPersonAccounts){
				if ( personAccount.First_Name__c != oldMap.get(personAccount.Id).First_Name__c) {
					personAccount.Old_First_Name__c = oldMap.get(personAccount.Id).First_Name__c;
				}
			}
		}
		if (fieldPermission.isUpdateable('Person_Account__c','Old_Last_Name__c') && fieldPermission.isAccessible('Person_Account__c','Last_Name__c')) {
			for ( Person_Account__c personAccount : newPersonAccounts){
				if ( personAccount.Last_Name__c != oldMap.get(personAccount.Id).Last_Name__c) {
					personAccount.Old_Last_Name__c = oldMap.get(personAccount.Id).Last_Name__c;
				}
			}
		}

	}
	private String convertAddressObjectToString(Address address){
		if (address == null){
			return null;
		}
		return  (address.country != null?address.country  + ',':'') + (address.city != null?address.city  + ',':'') + (address.state != null?address.state  + ',':'') + (address.street != null?address.street  + ',':'') + (address.postalCode != null?address.postalCode :'');
	}
}