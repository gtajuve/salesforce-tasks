/**
 * PersonAccountScheduler class
 * @author CloudMyBiz (r)
 * @date 8/13/19
 * @description
 * @group 
 */

global with sharing class PersonAccountScheduler implements Schedulable {

	global void execute(SchedulableContext SC) {
		Database.executeBatch(new PersonAccountBatch());
	}

}