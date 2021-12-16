//Import
const cds = require("@sap/cds");

//Service implementation with all the service handler

module.exports = cds.service.impl( async function () {
    //defind constant 

    const {Risks , BusinessPartners} = this.entities ;

    //Set criticality after a read operation on Risks

    this.after("READ", Risks, (data) =>{

        const risks = Array.isArray(data) ? data : [data];

        risks.forEach((risk) => {

            if (risk.impact >= 10000) {
                risk.criticality = 1 ;
            }else {
                risk.criticality = 2 ;
            }

        });
    });
    


//connect to external service 
const BPsrv = await cds.connect.to("API_BUSINESS_PARTNER");

this.on("READ", BusinessPartners, async (req) => {


req.query.where("LastName <> '' and FirstName <> '' ");

return await BPsrv.transaction(req).send({
    query: req.query,
    headers : {apikey : process.env.apikey},

});

});

try{
    // eslint-disable-next-line no-undef
    const res = await next();
    await Promise.all(

        res.map(async (risk) => {

            // eslint-disable-next-line no-undef
            const bp = await BPsrv.transaction(req).send({
                query: SELECT.one(this.entities.BusinessPartners)
                .where({BusinessPartner: risk.bp_BusinessPartner})
                .columns(['BusinessPartner', "LastName" , "FristName"]),
                headers : {apikey : process.env.apikey,
                },
            });
            risk.bp = bp
        })


    );



// eslint-disable-next-line no-empty
}catch(error){

}


});
