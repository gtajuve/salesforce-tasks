/**
 * FieldsPermission class
 * @author CloudMyBiz (r)
 * @date 8/14/19
 * @description
 * @group 
 */

public with sharing class FieldsPermission {

	public Boolean isCreatable(String sObjectName, String fieldName){
		Map<String, Schema.SObjectField> mapFieldList = Schema.getGlobalDescribe().get(sObjectName).getDescribe().fields.getMap();
		return mapFieldList.get(fieldName.toLowerCase()).getDescribe().isCreateable();
	}
	public Boolean isUpdateable(String sObjectName, String fieldName){
		Map<String, Schema.SObjectField> mapFieldList = Schema.getGlobalDescribe().get(sObjectName).getDescribe().fields.getMap();
		return mapFieldList.get(fieldName.toLowerCase()).getDescribe().isUpdateable();
	}
	public Boolean isAccessible(String sObjectName, String fieldName){
		Map<String, Schema.SObjectField> mapFieldList = Schema.getGlobalDescribe().get(sObjectName).getDescribe().fields.getMap();
		return mapFieldList.get(fieldName.toLowerCase()).getDescribe().isAccessible();
	}

}