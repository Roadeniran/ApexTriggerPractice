trigger AccountTrigger on Account (before update) {
    // Call the handler class to process the accounts
    AccountHandlerClass.ValidateOwnership(Trigger.new, Trigger.oldMap);

}