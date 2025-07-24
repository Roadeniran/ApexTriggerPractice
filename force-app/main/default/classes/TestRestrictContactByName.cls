 @isTest
public with sharing class TestRestrictContactByName {
    @isTest
    static void testValidContactName() {
        Contact c = new Contact(FirstName = 'John', LastName = 'Doe');
        Test.startTest();
        RestrictContactName.AddErrorName(new List<Contact>{c});
        Test.stopTest();

        // Should not throw any error, so test passes silently
        System.assertEquals('Doe', c.LastName);
    }
    
    @isTest
    static void testInvalidContactName() {
        Contact c = new Contact(FirstName = 'Jane', LastName = 'INVALIDNAME');
        
        Test.startTest();
        try {
            RestrictContactName.AddErrorName(new List<Contact>{c});
            // Simulate DML operation that would trigger the error
            insert c; // will fail because addError prevents DML
            System.assert(false, 'Expected error was not thrown');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('The Last Name'), 'Expected error message not found');
        }
        Test.stopTest();
    }
}