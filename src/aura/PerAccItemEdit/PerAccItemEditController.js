
({
    doInit: function(component, event, helper) {

        var pageReference = component.get("v.pageReference");
        component.set("v.account", pageReference.state.c__account);
        component.set("v.action", pageReference.state.c__action);
        helper.getFields(component);
    },
    handleSubmit:function (component, event, helper) {

    },
    handleSuccess:function (component, event, helper) {
        var resultsToast = $A.get("e.force:showToast");
        resultsToast.setParams({
            "title": "Success",
            "type": "success",
            "message": "The record was changed.",
            "duration": 5
        });
        resultsToast.fire();
        component.find("navigationService").navigate({
            type: 'standard__component',
            attributes: {
                componentName: 'c__PerAcc',
            }
        });
    },
    handleCancelClick: function(component, event, helper) {
        component.find("navigationService").navigate({
            type: 'standard__component',
            attributes: {
                componentName: 'c__PerAcc',
            }
        });
    }

})