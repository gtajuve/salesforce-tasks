/**
 * PersonAccountsController class
 * @author CloudMyBiz (r)
 * @date 8/19/19
 * @description
 * @group 
 */

public with sharing class PersonAccountsController {

	@AuraEnabled
	public static List <Person_Account__c> getPersonAccounts() {
		return [SELECT Id, First_Name__c, Last_Name__c,Old_First_Name__c,Old_Last_Name__c FROM Person_Account__c ORDER BY Name ASC];
	}
	@AuraEnabled
	public static void deletePersonAccount(Person_Account__c account) {
		delete account;
	}
	@AuraEnabled
	public static DynamicBindingWrapper objectRecords() {
		String selectedObject = 'Person_Account__c';
		List<String> defaultFields = new List<String>{
				'First_Name__c', 'Last_Name__c', 'Old_First_Name__c', 'Old_Last_Name__c', 'Account_Phone__c'
		};
		DynamicBindingWrapper dynamicData = new DynamicBindingWrapper();
		List<fieldDataWrapper> wrapperList = new List<fieldDataWrapper>();

		Map<String, Schema.SObjectField> mapFieldList = Schema.getGlobalDescribe().get(selectedObject).getDescribe().fields.getMap();
		System.debug(mapFieldList);
		for (Schema.SObjectField field : mapFieldList.values()) {
			Schema.DescribeFieldResult fieldResult = field.getDescribe();

			if (fieldResult.isAccessible() && defaultFields.contains(fieldResult.getName())) {
				fieldDataWrapper wrapper = new fieldDataWrapper();
				wrapper.label =fieldResult.getLabel();
				wrapper.fieldName = fieldResult.getName();
				wrapper.type = fieldResult.getType().name().toLowerCase();
				wrapperList.add(wrapper);
			}

		}

		String fieldsToFetch = String.join(defaultFields,',');

		String sql = ' SELECT ' + fieldsToFetch + ' FROM ' + selectedObject + ' ORDER BY CreatedDate ';

		dynamicData.sObjectData  = Database.query(sql);
		dynamicData.fieldList = wrapperList;

		return dynamicData;
	}

	//Class to store the dynamic data and list of related fields
	public class DynamicBindingWrapper {
		@AuraEnabled
		public List<Person_Account__c> sObjectData { get; set; }
		@AuraEnabled
		public List<fieldDataWrapper> fieldList { get; set; }
	}


	//Class to store the field information
	public class fieldDataWrapper {
		@AuraEnabled
		public String label { get; set; }
		@AuraEnabled
		public String fieldName { get; set; }
		@AuraEnabled
		public String type { get; set; }
	}
}