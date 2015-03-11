(function(angular, app) {
    "use strict";
    app.service("salaryTaxService",["$http", function($http) {
        var salaryTaxLimits = function(){
            return $http.get("/salary_taxes/tax_limits.json")
        }

        var newSalaryTax = function(faculty_master_id){
            return $http.get("/faculty_masters/"+faculty_master_id+"/salary_taxes/new.json")
        }

        var createSalaryTax = function(faculty_master_id, salary_tax){
            return $http.post("/faculty_masters/"+faculty_master_id+"/salary_taxes.json", {salary_tax: salary_tax})
        }

        var edit = function(faculty_master_id, salary_tax_id){
            return $http.get("/faculty_masters/"+faculty_master_id+"/salary_taxes/"+salary_tax_id+"/edit.json")
        }
        
        var update = function(faculty_master_id, salary_tax){
            return $http.put("/faculty_masters/"+faculty_master_id+"/salary_taxes/"+salary_tax.id+".json", {salary_tax: salary_tax})
        }


        var component_monthly_report = function(faculty_master_id, component){
            return $http.get("/faculty_masters/"+faculty_master_id+"/salary_taxes/component_monthly_report.json?component="+component)
        }

        return {
            salaryTaxLimits : salaryTaxLimits,
            newSalaryTax : newSalaryTax,
            createSalaryTax : createSalaryTax,
            edit : edit,
            component_monthly_report : component_monthly_report, 
            update : update
        };
    }]);
})(angular,  myApp);


