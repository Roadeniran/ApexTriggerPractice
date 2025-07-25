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
            if(l.Industry = 'Healthcare' ){
                l.LeadSource = (l.Industry == 'Healthcare') ? 'Web' : l.LeadSource;
                l.SICCode = (l.Industry == 'Healthcare') ? '1234' : l.SICCode;
                l.Primary__c = (l.Industry == 'Healthcare') ? 'Yes' : l.Primary__c;
                leadsToUpdate.add(l);
            }
        }
        // Perform a single DML operation to update all leads
        update leadsToUpdate;

    }
}