public with sharing class RestrictContactName {
    public static void AddErrorName (List<Contact> contacts) {
        // Check contacts prior to insert or update for invalid data
        for (Contact c : contacts) {
            if (c.LastName == 'INVALIDNAME') {
                // invalidname is invalid
                c.addError('The Last Name "' + c.LastName + '" is not allowed for DML');
            }
        }
    }
   
}