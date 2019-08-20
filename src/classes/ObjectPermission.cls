/**
 * ObjectPermission class
 * @author CloudMyBiz (r)
 * @date 8/15/19
 * @description
 * @group 
 */

public with sharing class ObjectPermission {

	public  Boolean isContactAccessible(){
		return  Contact.SObjectType.getDescribe().isAccessible();
	}

	public  Boolean isPersonAccountCreatable(){
		return Person_Account__c.SObjectType.getDescribe().isCreateable();
	}
}