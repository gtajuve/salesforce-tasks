/**
 * savePersonAccountOldNamesTrigger class
 * @author CloudMyBiz (r)
 * @date 8/14/19
 * @description Trigger for Person_Account__c. Follows the One Trigger Per Object design pattern, which allows for the control of execution order and recursion
 * @group Triggers
 */
trigger savePersonAccountOldNamesTrigger on Person_Account__c (before insert, after insert, before update, after update, before delete, after delete) {
	PersonAccountHandler.handleTrigger(Trigger.new,Trigger.old,Trigger.newMap, Trigger.oldMap,Trigger.operationType);
}