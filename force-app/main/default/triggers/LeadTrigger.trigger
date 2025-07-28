trigger LeadTrigger on Lead (before update, after insert) {
    
    if (Trigger.isBefore && Trigger.isUpdate) {
        LeadHandler.setLeadStatus(Trigger.new);
        LeadHandler.updateHealthIndustry(Trigger.new);
    }
    if (Trigger.isAfter && Trigger.isInsert) {
        LeadHandler.createFollowUpTask(Trigger.new);
    }

}