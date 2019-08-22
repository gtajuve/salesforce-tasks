({
    init: function (component, event, helper) {
        helper.getFields(component);
    },

    handleRowAction: function (component, event, helper) {
        var action = event.getParam('action');
        var row = event.getParam('row');
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
                        "c__account":  component.get("v.account"),
                        "c__action":  'edit'
                    }
                });
                break;
            case 'delete':
                // component.set("v.isModalOpen", true);
                var modalBody;
                var modalFooter;
                var message = "Do you want to delete record?";

                $A.createComponents([
                        ["c:modalContent",{ message:message}],
                        ["c:modalFooter",{ account:component.get('v.account')}]
                    ],
                    function(components, status){
                        if (status === "SUCCESS") {
                            modalBody = components[0];
                            modalFooter = components[1];
                            modalFooter.addEventHandler('ClickOkModalEvent',function (event) {
                                var account = event.getParam("account");

                                helper.deleteAccount(component,account);
                            });
                            component.find('overlayLib').showCustomModal({
                                header: "Delete Confirmation",
                                body: modalBody,
                                footer: modalFooter,
                                showCloseButton: true,
                                cssClass: "my-modal,my-custom-class,my-other-class",
                                closeCallback: function() {

                                }
                            })
                        }
                    }
                );
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
    },
    handleClickNewRecord: function (component, event, helper) {
        component.find("navigationService").navigate({
            type: 'standard__component',
            attributes: {
                componentName: 'c__PerAccItemEdit',
            },
            state: {
                "c__action":  'new',
                "c__account":  null
            }
        });
    },
    handleDeleteRecordEvent:function (component, event, helper) {
        // var account = event.getParam("account");
        //
        // helper.deleteAccount(component,account);
    }

});