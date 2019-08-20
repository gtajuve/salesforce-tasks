/**
 * ContactHandler class
 * @author CloudMyBiz (r)
 * @date 8/19/19
 * @description
 * @group 
 */

public with sharing class ContactHandler{

	public static PersonAccountService pas = new PersonAccountService();
	public static AppSettings appSettings = new AppSettings();

	public static void handleTrigger(List<Contact> contacts, System.TriggerOperation triggerEvent ) {

		switch on triggerEvent {

			when AFTER_INSERT {
				if (appSettings.getEnableAddPersonAccount()) {
					pas.createPersonAccount(contacts);
				}
			}
			when AFTER_UPDATE {

			}
			when BEFORE_INSERT {

			}
			when BEFORE_UPDATE {

			}
			when AFTER_DELETE {

			}
			when BEFORE_DELETE {

			}
			when else {

			}
		}
	}
}

