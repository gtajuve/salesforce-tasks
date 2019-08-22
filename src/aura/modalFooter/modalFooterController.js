
({
    handleCancel : function(component, event, helper) {
        //closes the modal or popover from the component
        component.find("overlayLib").notifyClose();
    },
    handleOK : function(component, event, helper) {
        var account = component.get('v.account');
        var compEvent = component.getEvent("ClickOkModalEvent");
        // var compEvent = $A.get("e.c:OnClickOkModalEvent");

        compEvent.setParams({"account":account});
        compEvent.fire();
        component.find("overlayLib").notifyClose();
    }
})