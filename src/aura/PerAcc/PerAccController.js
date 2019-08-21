({
    init: function (component, event, helper) {
        helper.getFields(component);
    },

    handleRowAction: function (component, event, helper) {
        var action = event.getParam('action');
        var row = event.getParam('row');
        console.log(row.Id);
        component.set('v.account',row);
        switch (action.name) {
            case 'edit':
                // alert('Showing Details: ' + JSON.stringify(row));
                component.find("navigationService").navigate({
                    type: 'standard__component',
                    attributes: {
                        componentName: 'c__PerAccItemEdit',
                    },
                    state: {
                        "c__account":  component.get("v.account")
                    }
                });
                break;
            case 'delete':
                component.set("v.isModalOpen", true);
                break;
        }
    },
    closeModel: function(component, event, helper) {

        component.set("v.isModalOpen", false);
    },

    submitDetails: function(component, event, helper) {
        var account = component.get('v.account');

        helper.deleteAccount(component,account);
        component.set("v.isModalOpen", false);
        // helper.removePerAcc(component,account);
    },

});