/**
 * InsertPersonAccountTrigger class
 * @author CloudMyBiz (r)
 * @date 8/13/19
 * @description Trigger for Contact. Follows the One Trigger Per Object design pattern, which allows for the control of execution order and recursion
 * @group Triggers
 */
trigger InsertPersonAccountTrigger on Contact (before insert, after insert, before update, after update, before delete, after delete) {
	ContactHandler.handleTrigger(Trigger.new,Trigger.old,Trigger.newMap, Trigger.oldMap,Trigger.operationType);
}

