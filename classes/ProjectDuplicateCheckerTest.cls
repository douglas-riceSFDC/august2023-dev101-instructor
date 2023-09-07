@isTest
private class ProjectDuplicateCheckerTest {

    @isTest
    static void checkForDuplicateProjectNames_givenMultipleDuplicates_shouldReturnAll() {
        List<Project__c> projects = new List<Project__c>();
        Project__c firstProject = new Project__c();
        firstProject.Name = 'Test Project';
        projects.add(firstProject);

        Project__c secondProject = new Project__c();
        secondProject.Name = 'Test Project';
        projects.add(secondProject);

        Project__c thirdProject = new Project__c();
        thirdProject.Name = 'Test Project';
        projects.add(thirdProject);

        insert projects;

        Test.startTest();

        List<ProjectDuplicateChecker.ProjectDuplicateInput> inputs = 
            new List<ProjectDuplicateChecker.ProjectDuplicateInput>();

        ProjectDuplicateChecker.ProjectDuplicateInput input = 
            new ProjectDuplicateChecker.ProjectDuplicateInput();
        input.project = firstProject.Id;

        inputs.add(input);

        List<ProjectDuplicateChecker.ProjectDuplcateOutput> output = 
            ProjectDuplicateChecker.checkForDuplicateProjectNames(inputs);

        Test.stopTest();

        Assert.areEqual(1, output.size(), 'There should have been an output.');
        Assert.isTrue(output[0].duplicateIds.contains(secondProject.Id), 'The second project Id should have been returned');
        Assert.isTrue(output[0].duplicateIds.contains(thirdProject.Id), 'The third project Id should have been returned');
        Assert.isFalse(output[0].duplicateIds.contains(firstProject.Id), 'The first project Id should not have been returned');

    }
}