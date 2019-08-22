
({
    deleteAccount: function(component, account) {
        var action = component.get('c.deletePersonAccount');

        action.setParams({
            'account': account
        });

        action.setCallback(this, function(response) {
            var state = response.getState();

            if (state === "SUCCESS" || state === "DRAFT") {

                var resultsToast = $A.get("e.force:showToast");
                resultsToast.setParams({
                    "title": "Success",
                    "type": "success",
                    "message": "The record was deleted.",
                    "duration": 5
                });
                resultsToast.fire();
            } else if (state === "ERROR") {

                var resultsToast = $A.get("e.force:showToast");
                resultsToast.setParams({
                    "title": "Unsuccess",
                    "message": "The record wasn't deleted."
                });
                resultsToast.fire();

            } else {


            }
        });
        $A.enqueueAction(action);
    }
});