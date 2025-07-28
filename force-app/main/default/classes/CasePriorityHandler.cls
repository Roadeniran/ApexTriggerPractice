public with sharing class CasePriorityHandler {
    public static void setCasePriority(List<case> cases) {
        if(cases == null || cases.isEmpty()) {
            return;
        }
        // Create a list to hold cases to update to avoid DML operations in a loop
        List<case> casesToInsert = new List<Case>();
        for (case c : cases){
            if (c.Priority == null ){
                // Set the priority based on the case origin
                // Assuming 'Phone' cases are high priority, others are low
                c.Priority = (c.Origin == 'Phone') ? 'High' : 'Low';
            }
            casesToInsert.add(c);
        }
        // Perform a single DML operation to update all cases
        insert casesToInsert;
    }
}