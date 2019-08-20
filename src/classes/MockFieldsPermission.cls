/**
 * MockFieldsPermission class
 * @author CloudMyBiz (r)
 * @date 8/16/19
 * @description
 * @group 
 */

public with sharing class MockFieldsPermission implements System.StubProvider{

	private List<String> accessibleFields;
	private List<String> creatableFields;
	private List<String> updateableFields;

	public MockFieldsPermission(List<String> creatableFields,List<String> accessibleFields, List<String> updateableFields) {
		this.creatableFields = creatableFields;
		this.accessibleFields = accessibleFields;
		this.updateableFields = updateableFields;
	}

	public Object handleMethodCall(Object stubbedObject, String stubbedMethodName,Type returnType, List<Type> listOfParamTypes, List<String> listOfParamNames,List<Object> listOfArgs) {
		switch on stubbedMethodName {
			when 'isPersonAccountFieldCreatable'{
				return this.creatableFields.contains((String) listOfArgs[0]);
			}
			when 'isPersonAccountFieldUpdateable'{
				return this.updateableFields.contains((String) listOfArgs[0]);
			}
			when 'isContactFieldAccessible'{
				return this.accessibleFields.contains((String) listOfArgs[0]);
			}
		}
		return null;
	}
}