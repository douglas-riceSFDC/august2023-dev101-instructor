import { LightningElement, wire } from 'lwc';

import { publish, MessageContext } from 'lightning/messageService';
import newTimesheets from '@salesforce/messageChannel/NewTimesheets__c';

export default class TimesheetEditForm extends LightningElement {
    modalShown = false;

    @wire(MessageContext)
    messageContext;

    toggleModal() {
        this.modalShown = !this.modalShown;
    }

    handleFormSuccess() {
        publish(this.messageContext, newTimesheets, {});
    }
}