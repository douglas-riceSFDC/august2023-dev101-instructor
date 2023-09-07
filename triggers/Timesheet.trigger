trigger Timesheet on Timesheet__c (before update, after insert, after update) {

    if(Trigger.isBefore && Trigger.isUpdate) {
        TimesheetRejector rejector = new TimesheetRejector();
        rejector.incrementCountOnRejection(Trigger.new, Trigger.oldMap);
    } else if(Trigger.isAfter && Trigger.isInsert) {
        TimesheetReminderGenerator.generateSubmissionReminder(Trigger.new);
    } else if(Trigger.isAfter && Trigger.isUpdate) {
        TimesheetReminderGenerator.closeRemindersOnSubmission(Trigger.new, Trigger.oldMap);
    }
}