trigger OpportunityTrigger on Opportunity (after update, before update, after delete) {
    if (Trigger.isAfter && Trigger.isDelete) {
        OpportunityHandlerClass.createTaskForAccountOwner(Trigger.old, Trigger.oldMap);
        }
    if (Trigger.isAfter && Trigger.isUpdate) {
    OpportunityHandlerClass.createTaskReminder(Trigger.new, Trigger.oldMap);
    }
    if (Trigger.isBefore && Trigger.isUpdate) {
        OpportunityHandlerClass.updateOpportunityAmount(Trigger.new, Trigger.oldMap);
    }
}