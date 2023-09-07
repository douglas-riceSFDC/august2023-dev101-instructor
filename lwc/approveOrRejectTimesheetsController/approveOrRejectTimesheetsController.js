import { LightningElement, api, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getRelatedTimesheets from '@salesforce/apex/ApproveOrRejectTimesheetsController.getRelatedTimesheets';
import approveTimesheets from '@salesforce/apex/ApproveOrRejectTimesheetsController.approveTimesheets';
import rejectTimesheets from '@salesforce/apex/ApproveOrRejectTimesheetsController.rejectTimesheets';

export default class ApproveOrRejectTimesheetsController extends LightningElement {
    @api recordId;
    fetchedTimesheets;
    wiredResponse;

    @wire(getRelatedTimesheets, { projectId: '$recordId'})
    wiredTimesheets(response) {
        this.wiredResponse = response;

        console.log(response.data);

        this.fetchedTimesheets = response.data;
    }

    connectedCallback() {

    }

    handleApproval(event) {
        console.log('event handled.');

        let timesheets = event.detail.timesheets;

        console.log(JSON.parse(JSON.stringify(timesheets)));

        approveTimesheets( { timesheetsToApprove: timesheets} )
            .then(response => {
                console.log('approved.');

                refreshApex(this.wiredResponse);
            })
            .catch(error => {
                console.warn(error);
            });
    }

    handleReject(event) {
        console.log('event handled.');

        let timesheets = event.detail.timesheets;

        console.log(JSON.parse(JSON.stringify(timesheets)));

        rejectTimesheets( { timesheetsToReject: timesheets} )
            .then(response => {
                console.log('rejected.');

                refreshApex(this.wiredResponse);
            })
            .catch(error => {
                console.warn(error);
            });        
    }
}