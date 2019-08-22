/**
 * AccItemController.js Controller
 * @author CloudMyBiz (r)
 * @date 6/25/19
 * @description
 *
 * @group Lightning Controllers
 *
 */
({
    handleViewDetailsClick: function(component, event, helper) {
        var account = component.get("v.account");
        component.find("navigationService").navigate({
            type: 'standard__component',
            attributes: {
                componentName: 'c__AccShowItem',
            },
            state: {
                "c__accountId":  component.get("v.account.Id"),
                "c__account":  component.get("v.account")
            }
        });

    },
    handleEditClick: function(component, event, helper) {
        component.find("navigationService").navigate({
            type: 'standard__component',
            attributes: {
                componentName: 'c__AccEditItem',
            },
            state: {
                "c__accountId":  component.get("v.account.Id"),
                "c__account":  component.get("v.account")
            }
        });


    },
    handleDeleteClick: function(component, event, helper) {

        var account = component.get("v.account");
        helper.deleteAccount(component, account);
    },
    refreshView: function(component, event, helper) {

        if (event.getParams().title == undefined) {
            $A.get('e.force:refreshView').fire();
        }
    }
})