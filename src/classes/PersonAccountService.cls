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
		if (this.fieldPermission.isContactFieldAccessible('FirstName') && this.fieldPermission.isPersonAccountFieldCreatable('First_Name__c')) {
			perAcc.First_Name__c = cont.FirstName;
		}
		if (this.fieldPermission.isContactFieldAccessible('LastName') && this.fieldPermission.isPersonAccountFieldCreatable('Last_Name__c')) {
			perAcc.Last_Name__c = cont.LastName;
		}

		if (this.fieldPermission.isContactFieldAccessible('MailingAddress') && this.fieldPermission.isPersonAccountFieldCreatable('Mailing_Address__c')) {
			perAcc.Mailing_Address__c = convertAddressObjectToString(cont.MailingAddress);
		}

		if (this.fieldPermission.isContactFieldAccessible('OtherAddress') && this.fieldPermission.isPersonAccountFieldCreatable('Other_Address__c')) {
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

	public void copyPersonAccountOldName(Person_Account__c newPersonAccount, Person_Account__c oldPersonAccount, Set<String> updateableFields){

		if( updateableFields.contains('Old_First_Name__c') && newPersonAccount.First_Name__c != oldPersonAccount.First_Name__c )
		{
			newPersonAccount.Old_First_Name__c = oldPersonAccount.First_Name__c;
		}
		if( updateableFields.contains('Old_Last_Name__c') && newPersonAccount.Last_Name__c != oldPersonAccount.Last_Name__c )
		{
			newPersonAccount.Old_Last_Name__c = oldPersonAccount.Last_Name__c;
		}
	}
	private String convertAddressObjectToString(Address address){
		if (address == null){
			return null;
		}
		return  (address.country != null?address.country  + ',':'') + (address.city != null?address.city  + ',':'') + (address.state != null?address.state  + ',':'') + (address.street != null?address.street  + ',':'') + (address.postalCode != null?address.postalCode :'');
	}
}