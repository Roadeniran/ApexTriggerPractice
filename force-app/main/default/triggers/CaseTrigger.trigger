trigger CaseTrigger on Case (before insert) {
    if (Trigger.isBefore && Trigger.isInsert) {
        CasePriorityHandler.setCasePriority(Trigger.new);
    }

}