trigger OpportunityTrigger on Opportunity (after update) {
    OpportunityHandlerClass.createTaskReminder(Trigger.new, Trigger.oldMap);
}