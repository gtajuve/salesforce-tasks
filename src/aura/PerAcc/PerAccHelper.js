({
    // Fetch the accounts from the Apex controller
    getPersonAccountList: function(component) {
        var action = component.get('c.getPersonAccounts');
        // Set up the callback
        var self = this;
        action.setCallback(this, function(actionResult) {
            component.set('v.data', actionResult.getReturnValue());
        });
        $A.enqueueAction(action);
    }
})