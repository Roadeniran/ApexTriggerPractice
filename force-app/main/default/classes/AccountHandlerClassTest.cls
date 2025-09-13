@isTest
private class AccountHandlerClassTest {


@IsTest
    static void testValidateOwnership() {
        // Create a test Account with 'private' ownership
        Account testAccount = new Account(Name = 'Test Account', Ownership = 'private');
        insert testAccount;

        // Create a test user with a profile other than 'System Administrator'
        Profile nonAdminProfile = [SELECT Id FROM Profile WHERE Name != 'System Administrator' LIMIT 1];
        User nonAdminUser = new User(
            ProfileId = nonAdminProfile.Id,
            Username = 'nonadminuser@test.com',
            Email = 'nonadminuser@test.com',
            LastName = 'Test',
            FirstName = 'NonAdmin',
            Alias = 'nadmin',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            TimeZoneSidKey = 'America/Los_Angeles'
        );
        insert nonAdminUser;

        // Run the test as the non-admin user
        System.runAs(nonAdminUser) {
            // Attempt to update the Account ownership
            testAccount.Ownership = 'public';
            try {
                update testAccount;
                // If the update succeeds, fail the test
                System.assert(false, 'Validation should have prevented the update.');
            } catch (DmlException e) {
                // If the update fails, check if the error message is correct
                System.assertEquals('Ownership is Private. You cannot modify private account.', e.getDmlMessage(0));
            }
        }
    }
}