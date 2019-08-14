
({
    doInit: function(component, event, helper) {

        // helper.getAccountFieldsList(component);
        helper.getCurrentUserName(component);
    },
    handleSubmit:function (component, event, helper) {
        event.preventDefault(); // stop form submission
        var eventFields = event.getParam("fields");

        if(eventFields.Name != undefined && eventFields.Name.indexOf(component.get('v.userName')) == -1){
            eventFields['Name'] = eventFields['Name']+ ' '+ component.get('v.userName');
        }

        component.find("myform").submit(eventFields);
        var evt = $A.get("e.force:navigateToComponent");
        evt.setParams({
            componentDef: "c:AccShowItem",
            componentAttributes: {
                accountId: component.get("v.account.Id")
            }
        });
        evt.fire();

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
    },
    getInputFields:function (component, event, helper) {
        var fields = component.find("fieldsNames").get("v.value");
        if (fields.length > 0) {
            component.set('v.accountFields', fields.split(','));
            $A.util.addClass(component.find("chooseFields"), "slds-hide");
            $A.util.removeClass(component.find("inputForm"), "slds-hide");
        }
    }

})