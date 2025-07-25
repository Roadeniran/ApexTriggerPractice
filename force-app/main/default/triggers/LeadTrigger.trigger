trigger LeadTrigger on Lead (before update) {
    
    if (Trigger.isBefore && Trigger.isUpdate) {
        LeadHandler.setLeadStatus(Trigger.new);
        LeadHandler.updateHealthIndustry(Trigger.new);
    }


}