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
    // This method is used to update the Opportunity's amount based on the stagename 
    public static void updateOpportunityAmount(List<Opportunity> Opportunities, Map<Id,Opportunity> OldMap) {
        if (Opportunities == null || Opportunities.isEmpty()) {
            return; // Exit if the list is null or empty
        }
        for (Opportunity opp : Opportunities) {
            Opportunity OldOpp = OldMap.get(opp.Id);
            if (opp.StageName != OldOpp.StageName ) {
                // Using a ternary operator to apply discounts based on the stage name
                opp.Amount = opp.StageName == 'Closed Won'? opp.Amount * 0.5 : // Apply a 50% discount on the amount
                    (opp.Amount = opp.StageName == 'Negotiation/Review'? opp.Amount * 0.9 : opp.Amount) ; // Apply a 10% discount on the amount
            }
        }
    }

    // This method As soon as an Opportunity is deleted, create a Task for the Opportunity’s parent Account Owner.
    public static void createTaskForAccountOwner(List<Opportunity> Opportunities, Map<Id,Opportunity> oldMap){
        if (Opportunities == null || Opportunities.isEmpty()) {
            return; // Exit if the list is null or empty
        }
        
        // collect accountIds from opportunities, create a set to collect Ids
        Set<Id> accountIds = new Set<Id>();

    // Collect AccountIds safely
    for (Opportunity opp : opportunities) {
        Opportunity oldOpp = oldMap.get(opp.Id);
        if (oldOpp != null && oldOpp.AccountId != null) {
            accountIds.add(oldOpp.AccountId);
        }
    }

    // Query Account Owners, Get OwnerId for Account collected in accountIds
    Map<Id, Account> accountMap = new Map<Id, Account>(
        [SELECT Id, OwnerId FROM Account WHERE Id IN :accountIds]
    );

    List<Task> tasksToInsert = new List<Task>();// List to collet tasks to be created

        // loop through opportunities incase we have more than one opportunity to one account
    for (Opportunity opp : opportunities) {
        // since opportunity is deleted, we use oldMap to get the account Id
            Opportunity oldOpp = oldMap.get(opp.Id);
            if (oldOpp != null && oldOpp.AccountId != null) {
                Account acc = accountMap.get(oldOpp.AccountId);
                if (acc != null) {
                    Task tsk = new Task();
                    tsk.Subject = 'Opportunity Deleted - '+ oldOpp.Name ;
                    tsk.WhatId = oldOpp.AccountId;
                    tsk.OwnerId = acc.OwnerId;
                    tsk.Priority = 'Normal';
                    tsk.Status = 'Not Started';
                    tasksToInsert.add(tsk);
                }
            }
        }

        if (!tasksToInsert.isEmpty()) {
            insert tasksToInsert;
        }
    }
}