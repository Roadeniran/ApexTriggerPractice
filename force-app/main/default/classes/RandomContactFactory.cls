public class RandomContactFactory {
    
    public static List<Contact> generateRandomContacts(Integer numberOfContacts, String lastName) {
        List<Contact> contactList = new List<Contact>();
        
        for (Integer i = 0; i < numberOfContacts; i++) {
            Contact c = new Contact(
                FirstName = 'Test ' + i,
                LastName = lastName
            );
            contactList.add(c);
        }
        
        return contactList;
    }
}
