public with sharing class LeadHandler {
    public static void setLeadStatus(List<Lead> leads) {
        if (leads == null || leads.isEmpty()) {
            return;
        }
        // Create a list to hold leads to update to avoid DML operations in a loop
        List<lead> leadsToUpdate = new List<Lead>();
        for (Lead l: leads) {
            if(l.status != 'Working-Contacted' || l.status != null){
                l.status = 'Working-Contacted';
                leadsToUpdate.add(l);
            }
        }
        // Perform a single DML operation to update all leads
        update leadsToUpdate;

    }
    public static void updateHealthIndustry(List<Lead> leads) {
        if (leads == null || leads.isEmpty()) {
            return;
        }
        // Create a list to hold leads to update to avoid DML operations in a loop
        List<lead> leadsToUpdate = new List<Lead>();
        for (Lead l: leads) {
            if( l.Industry == 'Healthcare' ){
                l.LeadSource = 'Web';
                l.SICCode__c = '1234' ;
                l.Primary__c = 'Yes';
                leadsToUpdate.add(l);
            }
        }
        // Perform a single DML operation to update all leads
        update leadsToUpdate;

    }
    public static void createFollowUpTask(List<Lead> leads) {
        if (leads == null || leads.isEmpty()) {
            return;
        }
        // Create a list to hold leads to update to avoid DML operations in a loop
        List<Task> tasksToInsert = new List<Task>();
        for (Lead l: leads) {
           // Create a follow-up task for each lead
                Task t = new Task();
                t.Subject = 'Follow Up';
                t.WhoId = l.Id;
                t.Priority = 'Normal';
                t.Status = 'Not Started';
                t.OwnerId = l.OwnerId;
                t.ActivityDate = Date.today().addDays(7); // Set the follow-up date to 7 days from today
                tasksToInsert.add(t);
        }
        // Perform a single DML operation to insert all Tasks
        if(!tasksToInsert.isEmpty()) {   
        Insert tasksToInsert;
        }
    }

    
}