@isTest
private class TimesheetRejectorTest {

    private static Timesheet__c generateTimesheet(String status) {
        Project__c project = new Project__c();
        project.Name = 'Test Project';
        insert project;

        Timesheet__c timesheet = new Timesheet__c();
        timesheet.Project__c = project.Id;
        timesheet.Hours__c = 40;
        timesheet.Status__c = status;
        timesheet.Number_of_Times_Rejected__c = 0;        
        return timesheet;
    }

    @TestSetup
    static void setupTestData() {
        Timesheet__c timesheet = generateTimesheet('Draft');    
        insert timesheet;
    }

    @isTest
    static void incrementCountOnRejection_givenRejectedTimesheet_shouldIncrement() {
        Timesheet__c timesheet = [SELECT Status__c FROM Timesheet__c LIMIT 1];

        Test.startTest();

        timesheet.Status__c = 'Rejected';
        update timesheet;

        Test.stopTest();

        List<Timesheet__c> updatedTimesheets = [SELECT Number_of_Times_Rejected__c
                                                    FROM Timesheet__c
                                                    WHERE Id = :timesheet.Id];

        Assert.areEqual(1, updatedTimesheets[0].Number_of_Times_Rejected__c, 
                'The rejection count should have incremented.');
    }

    @isTest
    static void incrementCountOnRejection_givenAnApprovedTimesheet_shouldNotIncrement() {
        Timesheet__c timesheet = [SELECT Status__c FROM Timesheet__c LIMIT 1];

        Test.startTest();

        timesheet.Status__c = 'Approved';
        update timesheet;

        Test.stopTest();

        List<Timesheet__c> updatedTimesheets = [SELECT Number_of_Times_Rejected__c
                                                    FROM Timesheet__c
                                                    WHERE Id = :timesheet.Id];

        Assert.areEqual(0, updatedTimesheets[0].Number_of_Times_Rejected__c, 
                'The rejection count should not have incremented.');
    }

    @isTest
    static void incrementCountOnRejection_givenANullCount_shouldSetToZeroFirst() {
        Timesheet__c timesheet = [SELECT Status__c FROM Timesheet__c LIMIT 1];
        timesheet.Number_of_Times_Rejected__c = null;   

        Test.startTest();

        timesheet.Status__c = 'Rejected';
        update timesheet;

        Test.stopTest();

        List<Timesheet__c> updatedTimesheets = [SELECT Number_of_Times_Rejected__c
                                                    FROM Timesheet__c
                                                    WHERE Id = :timesheet.Id];

        Assert.areEqual(1, updatedTimesheets[0].Number_of_Times_Rejected__c, 
                'The rejection count should have incremented.');
    }

}