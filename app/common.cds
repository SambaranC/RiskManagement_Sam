using riskmanagement as rm from '../db/schema';

//Annotate Risk elements

annotate rm.Risks with {

    ID     @title : 'Risk';
    title  @title : 'Title';
    owner  @title : 'Owner';
    prio   @title : 'Priority';
    miti   @title : 'Mitigation';
    impact @title : 'Impact';
    bp  @title : 'BusinessPartner'
  

}

//Annotate Mitigation elements

annotate rm.Mitigations with {
    ID    @(
        UI.Hidden,
        Commong : {Text : descr}
    );
    owner @title : 'Owner';
    descr @title : 'Description'


}

annotate rm.Risks with {

    miti @(Common : {
    //Show text, not id for mitigation in the context of riks 
        Text            : miti.descr,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : 'Mitigations',
            CollectionPath : 'Mitigations',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : miti_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'descr'
                }

            ]
        },
    });


    bp @(Common : {
        ValueList       : {
            Label          : 'Business Partners',
            CollectionPath : 'BusinessPartners',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : bp_BusinessPartner,
                    ValueListProperty : 'BusinessPartner'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'LastName'
                },
                 {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'FirstName'
                }

            ]
        }

    })


}
using from './risks/annotations';
using from './common';

