/**
 * FieldsPermissionService class
 * @author CloudMyBiz (r)
 * @date 8/14/19
 * @description
 * @group 
 */

public with sharing class FieldsPermissionService {

	private static FieldsPermissionService instance = new FieldsPermissionService();
	private FieldsPermissionService(){

	}
	private Map<String,List<String>> creatableFields = new Map<String, List<String>>();
	private Map<String,List<String>> updateableFields = new Map<String, List<String>>();
	private Map<String,List<String>> accessibleFields = new Map<String, List<String>>();
	public static FieldsPermissionService getInstance(){
		// eager load of the class
		return instance;
	}

	public Boolean isCreatable(String sObjectName, String fieldName){
		if (this.creatableFields.containsKey(sObjectName)) {
			return this.creatableFields.get(sObjectName).contains(fieldName);
		}
		List<String> fields = new List<String>();
		Map<String, Schema.SObjectField> mapFieldList = Schema.getGlobalDescribe().get(sObjectName).getDescribe().fields.getMap();
		for (Schema.SObjectField field : mapFieldList.values()) {
			Schema.DescribeFieldResult fieldResult = field.getDescribe();

			if (fieldResult.isCreateable() ) {
				fields.add(fieldResult.getName());
			}
		}
		this.creatableFields.put(sObjectName,fields);
		return this.creatableFields.get(sObjectName).contains(fieldName);
	}
	public Boolean isUpdateable(String sObjectName, String fieldName){
		if (this.updateableFields.containsKey(sObjectName)) {
			return this.updateableFields.get(sObjectName).contains(fieldName);
		}
		List<String> fields = new List<String>();
		Map<String, Schema.SObjectField> mapFieldList = Schema.getGlobalDescribe().get(sObjectName).getDescribe().fields.getMap();
		for (Schema.SObjectField field : mapFieldList.values()) {
			Schema.DescribeFieldResult fieldResult = field.getDescribe();

			if (fieldResult.isUpdateable() ) {
				fields.add(fieldResult.getName());
			}
		}
		this.updateableFields.put(sObjectName,fields);
		return this.updateableFields.get(sObjectName).contains(fieldName);


	}
	public Boolean isAccessible(String sObjectName, String fieldName){
		if (this.accessibleFields.containsKey(sObjectName)) {
			return this.accessibleFields.get(sObjectName).contains(fieldName);
		}
		List<String> fields = new List<String>();
		Map<String, Schema.SObjectField> mapFieldList = Schema.getGlobalDescribe().get(sObjectName).getDescribe().fields.getMap();
		for (Schema.SObjectField field : mapFieldList.values()) {
			Schema.DescribeFieldResult fieldResult = field.getDescribe();

			if (fieldResult.isAccessible() ) {
				fields.add(fieldResult.getName());
			}
		}
		this.accessibleFields.put(sObjectName,fields);
		return this.accessibleFields.get(sObjectName).contains(fieldName);

	}

}