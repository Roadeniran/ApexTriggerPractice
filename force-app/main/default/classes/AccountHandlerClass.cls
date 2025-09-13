public with sharing class AccountHandlerClass {
    public static void ValidateOwnership(List<Account> accounts, Map<Id, Account> OldMap) {
        if (accounts == null || accounts.isEmpty()) {
            return; // Exit if the list is null or empty
        }
        // Check if current user is a System Administrator
        Boolean isSysAdmin = [
            SELECT Id FROM Profile 
            WHERE Id = :UserInfo.getProfileId() 
            AND Name = 'System Administrator' 
            LIMIT 1
        ].size() > 0;

        // Skip validation for Sys Admins
        if (isSysAdmin) {
            return;
        }

        // Validate ownership of accounts
        // If the ownership is 'private', throw an error if the ownership is being changed 
        
        for (Account acc : accounts) {
            Account OldAcc = OldMap.get(acc.Id);
            if (OldAcc.Ownership == 'private')
            {
                acc.addError('Ownership is Private. You cannot modify private account.');
            }

     }
    }
}