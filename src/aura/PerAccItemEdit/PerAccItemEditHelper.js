
({
    getFields: function(component) {

        var action = component.get('c.objectRecords');

        action.setCallback(this, function(actionResult) {
            var fields = actionResult.getReturnValue().fieldList;
            component.set('v.fields', fields);
        });
        $A.enqueueAction(action);
    }
});