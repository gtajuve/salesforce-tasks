/**
 * AccShowItemController.js Controller
 * @author CloudMyBiz (r)
 * @date 6/25/19
 * @description
 *
 * @group Lightning Controllers
 *
 */

({
    init: function(cmp, event, helper) {
        var pageReference = cmp.get("v.pageReference");
        cmp.set("v.accountId", pageReference.state.c__accountId);
        cmp.set("v.account", pageReference.state.c__account);

    },
    handleRecordUpdated: function(component, event, helper) {
        var eventParams = event.getParams();
        if(eventParams.changeType === "LOADED") {
            // record is loaded (render other component which needs record data value)
            console.log("Record is loaded successfully.");
            console.log("You loaded a record in " +
                component.get("v.simpleRecord.Industry"));
        } else if(eventParams.changeType === "CHANGED") {
            // record is changed
        } else if(eventParams.changeType === "REMOVED") {
            // record is deleted
        } else if(eventParams.changeType === "ERROR") {
            // there’s an error while loading, saving, or deleting the record
        }
    }
})