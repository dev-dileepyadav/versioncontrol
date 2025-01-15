import LightningDataTable from 'lightning/datatable';
import customNameTemplate from "./customName.html";
import customImageTemplate from "./customImage.html";
import customRankTemplate from "./customRank.html";
import customPickList from "./customPickList.html";
import customEditPickList from "./customEditPickList";

export default class CustomDataTypeDataTable extends LightningDataTable {
    static customTypes = {
        customName:{
            template: customNameTemplate,
            standardCellLayout:true,
            typeAttributes: ["contactName"]
        },
        customRank:{
            template: customRankTemplate,
            standardCellLayout:false,
            typeAttributes: ["rankIcon"]
        },
        customImg:{
            template: customImageTemplate,
            standardCellLayout:false,
            typeAttributes: ["imageURL"]
        },
        customPickList:{
            template: customPickList,
            editTemplate: customEditPickList,
            standardCellLayout:false,
            typeAttributes: ["options","value","context"]
        }
    }
}