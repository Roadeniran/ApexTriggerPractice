trigger TaskTrigger on Task (before insert, after insert, before update, after update, before delete, after delete) {
    // Handle before insert logic
    if (Trigger.isBefore && Trigger.isInsert) {
        for (Task task : Trigger.new) {
            // put in logic
            TaskPriority.setTaskPriority(Trigger.new);
        }
    }

    // Handle after insert logic
    if (Trigger.isAfter && Trigger.isInsert) {
        for (Task task : Trigger.new) {
            // Example logic: Log the creation of the task
        }
    }

    // Handle before update logic
    if (Trigger.isBefore && Trigger.isUpdate) {
        for (Task task : Trigger.new) {
            // Example logic: Prevent changing the status to 'Completed'
            
        }
    }

    // Handle after update logic
    if (Trigger.isAfter && Trigger.isUpdate) {
        for (Task task : Trigger.new) {
            // Example logic: Log the update of the task
           
        }
    }

    // Handle before delete logic
    if (Trigger.isBefore && Trigger.isDelete) {
        for (Task task : Trigger.old) {
            // Example logic: Prevent deletion of tasks with high priority
           
        }
    }

    // Handle after delete logic
    if (Trigger.isAfter && Trigger.isDelete) {
        for (Task task : Trigger.old) {
            // Example logic: Log the deletion of the task
           
        }
    }

}