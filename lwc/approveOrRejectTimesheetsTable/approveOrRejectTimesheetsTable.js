import { LightningElement, api } from 'lwc';

export default class ApproveOrRejectTimesheetsTable extends LightningElement {
    @api timesheets;

    selectedTimesheets;

    columns = [
        { label: 'Name' , fieldName: 'Name' },
        { label: 'Hours', fieldName: 'Hours__c'},
        { label: 'Project Id', fieldName: 'Project__c'},
        { label: 'Status', fieldName: 'Status__c'}
    ];

    handleRowSelection(event) {
        let selectedRows = event.detail.selectedRows;

        console.log(JSON.parse(JSON.stringify(selectedRows)));

        this.selectedTimesheets = selectedRows;
    }

    approveSelectedTimesheets() {
        console.log('dispatch event');
        let eventPayload = {
            timesheets: this.selectedTimesheets
        };

        console.log(eventPayload);

        const timesheetsApprovalEvent = new CustomEvent('approvetimesheets', {
            detail: eventPayload
        });

        this.dispatchEvent(timesheetsApprovalEvent);
    }

    rejectSelectedTimesheets() {
        console.log('dispatch event');
        let eventPayload = {
            timesheets: this.selectedTimesheets
        };

        console.log(eventPayload);

        const timesheetsRejectionEvent = new CustomEvent('rejecttimesheets', {
            detail: eventPayload
        });

        this.dispatchEvent(timesheetsRejectionEvent);
    }

}