
({
    getFields: function(component) {

        var action = component.get('c.getUpdateableFields');
        var paramAction = component.get('v.action') === 'new'? 'create' :'update';
        action.setParams({
            'action': paramAction
        });

        action.setCallback(this, function(actionResult) {
            var fields = actionResult.getReturnValue();
            console.log(fields);
            component.set('v.fields', fields);
        });
        $A.enqueueAction(action);
    }
});