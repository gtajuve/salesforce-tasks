/**
 * MockSObjectsPermission class
 * @author CloudMyBiz (r)
 * @date 8/16/19
 * @description
 * @group 
 */

public with sharing class MockSObjectsPermission implements System.StubProvider{

	/**
     * Public MockSObjectsPermission constructor
     *
     */
	private Boolean isAccessibleContact;
	private Boolean isCreatablePersonAccount;
	public MockSObjectsPermission(Boolean isAccessibleContact, Boolean isCreatablePersonAccount) {
		this.isAccessibleContact = isAccessibleContact;
		this.isCreatablePersonAccount = isCreatablePersonAccount;
	}

	public Object handleMethodCall(Object stubbedObject, String stubbedMethodName,Type returnType, List<Type> listOfParamTypes, List<String> listOfParamNames,List<Object> listOfArgs) {
		switch on stubbedMethodName{
			when 'isContactAccessible'{
				return this.isAccessibleContact;
			}
			when 'isPersonAccountCreatable'{
				return this.isCreatablePersonAccount;
			}
		}
		return null;
	}
}