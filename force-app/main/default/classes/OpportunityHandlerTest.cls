@isTest
private class OpportunityHandlerTest {


@IsTest
    static void testUpdateOpportunityAmount() {
        // Create a test Opportunity with a specific StageName and Amount
        Opportunity testOpportunity = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            Amount = 1000,
            CloseDate = Date.today()
        );
        insert testOpportunity;

        // Retrieve the inserted Opportunity
        Opportunity insertedOpportunity = [SELECT Id, Amount, StageName FROM Opportunity WHERE Id = :testOpportunity.Id];

        // Create a map to simulate the OldMap parameter
        Map<Id, Opportunity> oldMap = new Map<Id, Opportunity>();
        oldMap.put(insertedOpportunity.Id, insertedOpportunity);

        // Modify the StageName to trigger the update logic
        insertedOpportunity.StageName = 'Closed Won';
        update insertedOpportunity;

        // Retrieve the updated Opportunity
        Opportunity updatedOpportunity = [SELECT Id, Amount, StageName FROM Opportunity WHERE Id = :testOpportunity.Id];

        // Call the method to be tested
        Test.startTest();
        OpportunityHandlerClass.updateOpportunityAmount(new List<Opportunity>{ updatedOpportunity }, oldMap);
        Test.stopTest();

        // Retrieve the updated Opportunity after the method execution
        Opportunity finalOpportunity = [SELECT Id, Amount, StageName FROM Opportunity WHERE Id = :testOpportunity.Id];

        // Verify that the Amount has been updated correctly
        System.assertEquals(500, finalOpportunity.Amount, 'Amount should be updated to 50% of the original value');
    }



@IsTest
    static void testCreateTaskForAccountOwner() {
        // Create a test Account
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Create a test Opportunity associated with the test Account
        Opportunity testOpportunity = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            Amount = 1000,
            CloseDate = Date.today(),
            AccountId = testAccount.Id
        );
        insert testOpportunity;

        // Retrieve the inserted Opportunity
        Opportunity insertedOpportunity = [SELECT Id, AccountId FROM Opportunity WHERE Id = :testOpportunity.Id];

        // Create a map to simulate the OldMap parameter
        Map<Id, Opportunity> oldMap = new Map<Id, Opportunity>();
        oldMap.put(insertedOpportunity.Id, insertedOpportunity);

        // Delete the Opportunity to trigger the logic
        delete insertedOpportunity;

        // Call the method to be tested
        Test.startTest();
        OpportunityHandlerClass.createTaskForAccountOwner(new List<Opportunity>{ insertedOpportunity }, oldMap);
        Test.stopTest();

        // Verify that a Task has been created for the Account Owner
        List<Task> createdTasks = [SELECT Id, Subject, WhatId, OwnerId FROM Task WHERE WhatId = :testAccount.Id];
        System.assertEquals(1, createdTasks.size(), 'Expected one Task to be created for the Account Owner');
    }
}