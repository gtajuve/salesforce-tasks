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
        // var navEvent = $A.get("e.force:navigateToSObject");
        // navEvent.setParams({
        //     recordId: account.Id,
        //     slideDevName: "details"
        // });
        // navEvent.fire();
        var evt = $A.get("e.force:navigateToComponent");
        evt.setParams({
            componentDef: "c:AccShowItem",
            componentAttributes: {
                accountId: component.get("v.account.Id")
            }
        });
        evt.fire();

    },
    handleEditClick: function(component, event, helper) {
        // var account = component.get("v.account");
        // var editRecordEvent = $A.get("e.force:editRecord");
        // editRecordEvent.setParams({
        //     "recordId": account.Id
        // });
        // editRecordEvent.fire();

        var evt = $A.get("e.force:navigateToComponent");
        evt.setParams({
            componentDef: "c:AccEditItem",
            componentAttributes: {
                accountId: component.get("v.account.Id")
            }
        });
        evt.fire();

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