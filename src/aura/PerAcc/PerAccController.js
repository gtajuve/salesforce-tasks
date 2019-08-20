({
    init: function (cmp, event, helper) {
        cmp.set('v.columns', [
            {label: 'First Name', fieldName: 'First_Name__c', type: 'text'},
            {label: 'Last Name', fieldName: 'Last_Name__c', type: 'text'},
            {label: 'Old First Name', fieldName: 'Old_First_Name__c', type: 'text'},
            {label: 'Old Last Name', fieldName: 'Old_Last_Name__c', type: 'text'},
            {label: 'Account Phone', fieldName: 'Account_Phone__c', type: 'phone'},

        ]);

        helper.getPersonAccountList(cmp);
    }
});