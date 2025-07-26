public with sharing class OpportunityHandlerClass {
    public static void createTaskReminder(List<Opportunity> Opportunities, Map<Id,Opportunity> OldMap) {
        // List to hold tasks to be created
        List<Task> tasksToInsert = new List<Task>();
        if (Opportunities == null || Opportunities.isEmpty()) {
            return; // Exit if the list is null or empty
        }

        for (Opportunity opp : Opportunities) {
            Opportunity OldOpp = OldMap.get(opp.Id);
            if (opp.StageName != OldOpp.StageName && opp.StageName == 'Closed Won')  {
                Task tsk = new Task();
                tsk.Subject = 'Split Opportunity Revenue Reminder';
                tsk.WhatId = opp.Id;
                tsk.OwnerId = opp.OwnerId;
                tsk.Priority = 'Normal';
                tsk.Status = 'Not Started';
                tsk.ActivityDate = System.today().addDays(7); // Set reminder for 7 days from today
                tasksToInsert.add(tsk);
            }

        }
        // Insert the tasks if there are any to insert
        if (!tasksToInsert.isEmpty()){
        insert tasksToInsert;
        }
    }    
}