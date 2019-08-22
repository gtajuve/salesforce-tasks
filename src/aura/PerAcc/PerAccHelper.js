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
    },
    getFields: function(component) {
        var actions = [
            { label: 'Edit', name: 'edit' },
            { label: 'Delete', name: 'delete' }
        ];
        var actionColumn = {type: 'action', typeAttributes: { rowActions: actions }};
        var action = component.get('c.objectRecords');
        // Set up the callback
        var self = this;
        action.setCallback(this, function(actionResult) {
            var fields = actionResult.getReturnValue().fieldList;
            fields.push(actionColumn);
            component.set('v.columns', fields);
            component.set('v.data', actionResult.getReturnValue().sObjectData);
        });
        $A.enqueueAction(action);
    },

    removePerAcc: function (cmp, row) {
        var rows = cmp.get('v.data');
        var rowId =  row.Id;
        var newRows = rows.filter(function (value,index,arr) {
            return value.Id != rowId;
        });
        cmp.set('v.data', newRows);
    },

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
                this.removePerAcc(component,account);
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
})