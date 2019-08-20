/**
 * FieldsPermission class
 * @author CloudMyBiz (r)
 * @date 8/14/19
 * @description
 * @group 
 */

public with sharing class FieldsPermission {

	public Set<String> creatablePersonAccountFields = new Set<String>();
	public Set<String> updateablePersonAccountFields = new Set<String>();
	public Set<String> accessibleContactFields = new Set<String>();
	public FieldsPermission(){
		getCreatableFields();
		getAccessibleField();
	}
	public Boolean isPersonAccountFieldCreatable(String fieldName){
		return this.creatablePersonAccountFields.contains(fieldName);
	}
	public Boolean isPersonAccountFieldUpdateable(String fieldName){
		return this.updateablePersonAccountFields.contains(fieldName);
	}
	public Boolean isContactFieldAccessible(String fieldName){
		return this.accessibleContactFields.contains(fieldName);
	}

	private void getCreatableFields(){
		Set<String> creatableFields = new Set<String>();
		Map <String, Schema.SObjectField> fieldMap = Person_Account__c.SObjectType.getDescribe().fields.getMap();
		for (Schema.SObjectField field : fieldMap.values()){
			String fieldName = field.getDescribe().getName();
			if(field.getDescribe().isCreateable()){
				creatablePersonAccountFields.add(fieldName);
			}
			if(field.getDescribe().isUpdateable()){
				updateablePersonAccountFields.add(fieldName);
			}
		}
	}

	private void getAccessibleField(){
		Set<String> accessibleFields = new Set<String>();
		Map <String, Schema.SObjectField> fieldMap = Contact.SObjectType.getDescribe().fields.getMap();
		for (Schema.SObjectField field : fieldMap.values()){
			if(field.getDescribe().isAccessible()){
				accessibleContactFields.add(field.getDescribe().getName());
			}
		}
	}
}