public with sharing class ApproveOrRejectTimesheetsController {
    
    @AuraEnabled(cacheable=true)
    public static List<Timesheet__c> getRelatedTimesheets(Id projectId) {
        return [SELECT Id, Name, Project__c, Hours__c, Status__c
                FROM Timesheet__c
                WHERE Project__c = :projectId
        ];
    }

    @AuraEnabled
    public static void approveTimesheets(List<Timesheet__c> timesheetsToApprove) {
        try {
            for(Timesheet__c timesheet : timesheetsToApprove) {
                timesheet.Status__c = 'Approved';
            }
    
            update timesheetsToApprove;
    
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void rejectTimesheets(List<Timesheet__c> timesheetsToReject) {
        try {
            for(Timesheet__c timesheet : timesheetsToReject) {
                timesheet.Status__c = 'Rejected';
            }
    
            update timesheetsToReject;
    
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}