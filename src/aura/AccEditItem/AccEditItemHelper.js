
({
    getAccountFieldsList: function(component) {
        var action = component.get('c.getAccountFieldList');
        // Set up the callback
        var self = this;
        action.setCallback(this, function(actionResult) {
            component.set('v.accountFields', actionResult.getReturnValue());

        });
        $A.enqueueAction(action);
    },
    getCurrentUserName: function(component) {
        var action = component.get('c.fetchUser');
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                component.set("v.userName", storeResponse);
            }
        });
        $A.enqueueAction(action);

    }

});