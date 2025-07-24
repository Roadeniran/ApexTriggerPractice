public with sharing class TaskPriority {
    public static void setTaskPriority(List<Task> tasks) {
        // to exit the method if the list is null or empty
        if (tasks == null || tasks.isEmpty()) {
            return;
        }

        for (Task task : tasks) {
            if (task.Priority == null) {
                task.Priority = 'High'; // Default priority
            }
        }

        update tasks;

    }
}