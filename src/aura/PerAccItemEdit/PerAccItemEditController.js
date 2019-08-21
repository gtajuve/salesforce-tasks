
({
    doInit: function(component, event, helper) {
        var pageReference = component.get("v.pageReference");
        component.set("v.account", pageReference.state.c__account);
        helper.getFields(component);
    }
})