using RiskService as service from '../../srv/risk-service';

//Risk list report page

annotate RiskService.Risks with @(UI : {

  HeaderInfo      : {

        TypeName       : 'Risk',
        TypeNamePlural : 'Risks',
        Title          : {
            $Type : 'UI.DataField',
            Value : title
        },
        Description    : {
            $Type : 'UI.DataField',
            Value : title
        }
    },
    SelectionFields : [prio],
    Identification  : [{Value : title}],
     //Define the table column
    LineItem        : [
        {Value : title},
        {Value : miti_ID},
        {Value : owner},
        {Value : bp_BusinessPartner},
        {
            Value       : prio,
            Criticality : criticality
        },
        {
            Value       : impact,
            Criticality : criticality
        }

    ]

});

//Risk Object page

annotate RiskService.Risks with @(UI : {
    Facets : [{
    $Type  : 'UI.ReferenceFacet',
    Label  : 'Main',
    Target : '@UI.FieldGroup#Main',
}],
FieldGroup #Main : { Data: [

    {Value : miti_ID},
    {Value : owner},
    {Value : bp_BusinessPartner},
    {
        Value : prio,
        Criticality : criticality
    },
    {Value : impact,
     Criticality: criticality}
]},
});