import { LightningElement } from 'lwc';

export default class TimesheetEditForm extends LightningElement {
    modalShown = false;

    toggleModal() {
        this.modalShown = !this.modalShown;
    }
}