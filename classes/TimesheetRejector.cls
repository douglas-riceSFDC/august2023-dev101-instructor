public with sharing class TimesheetRejector {
    public TimesheetRejector() {

    }

    public void incrementCountOnRejection(List<Timesheet__c> updatedTimesheets,
                                            Map<Id, Timesheet__c> oldTimesheets) {
        
        for(Timesheet__c singleTimesheet : updatedTimesheets) {
            if(singleTimesheet.Status__c == 'Rejected' &&
                oldTimesheets.get(singleTimesheet.Id).Status__c != 'Rejected') {

                if(singleTimesheet.Number_of_Times_Rejected__c == null) {
                    singleTimesheet.Number_of_Times_Rejected__c = 0;
                }

                singleTimesheet.Number_of_Times_Rejected__c += 1;
            }
        }

    }
}