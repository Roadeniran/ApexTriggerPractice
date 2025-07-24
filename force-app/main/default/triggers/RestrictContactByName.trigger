trigger RestrictContactByName on Contact (before insert, before update) {
    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        RestrictContactName.AddErrorName(Trigger.new);
        }
}