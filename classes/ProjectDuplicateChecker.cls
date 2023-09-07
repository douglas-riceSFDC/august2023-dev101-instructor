public with sharing class ProjectDuplicateChecker {
    
    @InvocableMethod(category='Project' label='Project Dupe Checker')
    public static List<ProjectDuplcateOutput> checkForDuplicateProjectNames(List<ProjectDuplicateInput> input) {
        List<Project__c> projects = [SELECT Name
                                        FROM Project__c
                                        WHERE Id = :input[0].project];

        List<Id> duplicateIds = new List<Id>();
        List<Project__c> duplicateProjects = [SELECT Id, Name
                                                FROM Project__c
                                                WHERE Name = :projects[0].Name
                                                    AND Id != :projects[0].Id];
        
        for(Project__c p : duplicateProjects) {
            duplicateIds.add(p.Id);
        }

        ProjectDuplcateOutput returnValue = new ProjectDuplcateOutput();
        returnValue.duplicateIds = duplicateIds;

        return new List<ProjectDuplcateOutput>{ returnValue };
    }

    public class ProjectDuplicateInput {

        @InvocableVariable
        public Id project;

        @InvocableVariable
        public Date todaysDate;

        @InvocableVariable
        public String userEmail;

    }

    public class ProjectDuplcateOutput {

        @InvocableVariable
        public List<Id> duplicateIds;

        @InvocableVariable
        public Date tomorrowsDate;

    }
}