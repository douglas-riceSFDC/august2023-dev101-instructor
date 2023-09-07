public with sharing class TimesheetReminderGenerator {
    
    public static void generateSubmissionReminder(List<Timesheet__c> insertedTimesheets) {

        List<Task> newReminders = new List<Task>();
        for(Timesheet__c timesheet : insertedTimesheets) {
            Task reminder = new Task();
            reminder.Subject = 'Submit your timesheet!';
            reminder.ActivityDate = Date.today() + 7;
            reminder.WhatId = timesheet.Id;

            newReminders.add(reminder);
        }

        insert newReminders;
    }

    public static void closeRemindersOnSubmission(List<Timesheet__c> updatedTimesheets,
                                                    Map<Id, Timesheet__c> oldTimesheets) {

        System.debug(updatedTimesheets);
        System.debug(oldTimesheets);
        
        List<Id> newlySubmittedTimesheetIds = new List<Id>();
        for(Timesheet__c timesheet : updatedTimesheets) {
            if(timesheet.Status__c == 'Submitted' &&
                oldTimesheets.get(timesheet.Id).Status__c != 'Submitted') {

                newlySubmittedTimesheetIds.add(timesheet.Id);
            }
        }

        List<Task> reminders = [SELECT Id, Status
                                FROM Task
                                WHERE WhatId IN :newlySubmittedTimesheetIds];
        
        System.debug('Reminders - ' + reminders);

        for(Task reminder : reminders) {
            System.debug('Completed this one');
            reminder.Status = 'Completed';
        }

        update reminders;
    }
}