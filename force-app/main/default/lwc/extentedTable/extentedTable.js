import LightningDatatable from 'lightning/datatable';
import imageTemplate from './templates/image.html';
import picklistTemplate from './templates/pickList.html';

export default class ExtentedTable extends LightningDatatable {

    static customTypes = {
        image:{
            template:imageTemplate,
            typeAttributes:['height', 'width', 'alt']
        },
        pickList:{
            template: picklistTemplate,
            typeAttributes: ['name', 'label', 'value', 'placeholder', 'options', 'index', 'variant']
        }
    }
}