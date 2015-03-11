(function(angular, app) {
    "use strict";
    app.controller("SalaryTaxController", ["$scope", "$window", "salaryTaxService", function($scope, $window, salaryTaxService) {
        
        $scope.taxLimits = null
        $scope.rentReceivedPerMonth = 0;

        var initSalaryTaxLimits = function(){
            salaryTaxService.salaryTaxLimits()
                .then(function(response){
                    $scope.taxLimits = response.data
                    $scope.calculateTax()
                    $scope.broadCastRent();
                    $scope.broadCastRentRecieved();
                })
        }

        $scope.initialize = function(faculty_master_id){
            $scope.facultyMasterId = faculty_master_id
            $scope.newSalaryTax()
        }

        $scope.newSalaryTax = function(){
            salaryTaxService.newSalaryTax($scope.facultyMasterId)
                .then(function(response){
                    $scope.salaryTax = response.data
                    initSalaryTaxLimits();
                })
        }

        $scope.broadCastRent = function(){
            $scope.salaryTax.rent_per_year = $scope.salaryTax.rent_per_month * 12
            if($scope.salaryTax.rent_per_year > 0){
                $scope.rent_excess_salary = $window.Math.abs($scope.salaryTax.rent_per_year - ($scope.salaryTax.basic * 0.1))
                $scope.salaryTax.rent_paid = $window.Math.min($scope.rent_excess_salary, $scope.salaryTax.hra)
            }else{
                $scope.salaryTax.rent_paid = 0
            }
            $scope.calculateFinalHouseRent()
        }

        $scope.broadCastRentRecieved = function(){
            $scope.salaryTax.rent_received_per_year =  ($scope.salaryTax.rent_received_per_month * 12)
            var rent_after_pt_wt =  ($scope.salaryTax.rent_received_per_year - $scope.salaryTax.pt_and_wt)
            var maintainanceCutoff = $scope.taxLimits.maintanance_on_rent_received
            $scope.salaryTax.rent_received = (rent_after_pt_wt - (rent_after_pt_wt * (maintainanceCutoff/100)))
            $scope.calculateFinalHouseRent()
        }

        var eligile_home_loan_interest = function(home_loan_interest){
            return (home_loan_interest > $scope.taxLimits.home_loan_interest_limit ? $scope.taxLimits.home_loan_interest_limit : home_loan_interest)
        }

        $scope.calculateFinalHouseRent = function(){
            if($scope.salaryTax.occupancy_type === 'let_out'){
                if($scope.salaryTax.rent_received <= 0){
                    $scope.salaryTax.final_hra_component = $scope.salaryTax.rent_paid + eligile_home_loan_interest($scope.salaryTax.employee_home_loan_interest)
                }else{
                    $scope.salaryTax.final_hra_component = $scope.salaryTax.rent_paid + $scope.salaryTax.employee_home_loan_interest - $scope.salaryTax.rent_received
                }
                
            }else if($scope.salaryTax.occupancy_type === 'own'){
                $scope.salaryTax.final_hra_component = eligile_home_loan_interest($scope.salaryTax.employee_home_loan_interest)
            }else if($scope.salaryTax.occupancy_type === 'rent'){
                $scope.salaryTax.final_hra_component = $scope.salaryTax.rent_paid
            }
            $scope.calculateTax()
        }
        
        $scope.addMoreMedicalInsurance = function(){
            var lastInsurance = $scope.salaryTax.medical_insurances[0]
            var newInsurance = {}
            angular.forEach(lastInsurance, function(val, key){
                newInsurance[key] = null
            })
            $scope.salaryTax.medical_insurances.push(newInsurance)
        }
        
        $scope.broadcastInsuranceAmount = function(){
            var total = 0
            var employee_insurance_amount = 0;
            var parent_insurance_amount = 0;
            var parent_senior_citizen_amount = 0;
            angular.forEach($scope.salaryTax.medical_insurances, function(val, index){
                var estimatedAmount = $scope.taxLimits.mediclaim_employee_limit
                if(val.amount != null){
                    if(val.parent_included && val.parent_senior_citizen){
                        parent_senior_citizen_amount += parseInt(val.amount)
                    }else if(val.parent_included){
                        parent_insurance_amount += parseInt(val.amount)
                    }else{
                        employee_insurance_amount += parseInt(val.amount)
                    }
                }
            })
            var parent_senior_citizen_limit = ($scope.taxLimits.mediclaim_parent_limit + $scope.taxLimits.mediclaim_parent_senior_citizen_limit)
            employee_insurance_amount = (employee_insurance_amount > $scope.taxLimits.mediclaim_employee_limit ? $scope.taxLimits.mediclaim_employee_limit : employee_insurance_amount)
            parent_insurance_amount = (parent_insurance_amount > $scope.taxLimits.mediclaim_parent_limit ? $scope.taxLimits.mediclaim_parent_limit : parent_insurance_amount)
            parent_senior_citizen_amount = (parent_senior_citizen_amount > parent_senior_citizen_limit ? parent_senior_citizen_limit : parent_senior_citizen_amount)
            $scope.salaryTax.medical_insurances_total = (employee_insurance_amount + parent_insurance_amount + parent_senior_citizen_amount)
            $scope.calculateTax()
        }

        $scope.addMoreMedicalBill = function(){
            var lastBill = $scope.salaryTax.medical_bills[0]
            var newBill = {}
            angular.forEach(lastBill, function(val, key){
                newBill[key] = null
            })
            $scope.salaryTax.medical_bills.push(newBill)
        }

        $scope.broadcastMedicalBillAmount = function(){
            var total = 0
            angular.forEach($scope.salaryTax.medical_bills, function(val, index){
                if(val.amount != null){
                    total += parseInt(val.amount)
                }
            })
            $scope.salaryTax.claimed_medical_bill = total > $scope.salaryTax.medical_allowance ? $scope.salaryTax.medical_allowance : total
            $scope.calculateTax()
        }

        $scope.addMoreSaving = function(){
            var lastSaving = $scope.salaryTax.savings[0]
            var newSaving = {}
            angular.forEach(lastSaving, function(val, key){
                newSaving[key] = null
            })
            $scope.salaryTax.savings.push(newSaving)
        }

        $scope.broadcastSavingsAmount = function(){
            var total = 0
            angular.forEach($scope.salaryTax.savings, function(val, index){
                if(val.amount != null){
                    total += parseInt(val.amount)
                }
            })
            total = total + $scope.salaryTax.pf
            $scope.salaryTax.savings_total = total > $scope.taxLimits.savings_up_to ? $scope.taxLimits.savings_up_to : total
            $scope.calculateTax()
        }
        
        $scope.totalAmountForTax = function(){
            $scope.totalAmountFor = $scope.salaryTax.total_earnings
        }

        $scope.calculateTax = function(){
            var total_earnings = totalEarnings()
            var total_deductions = totalDeductions()
            var total_amount = (total_earnings - total_deductions)
            var total_tax_projection = calculateIncomeTax(total_amount)
            var educational_cess = $window.Math.round( total_tax_projection * ($scope.taxLimits.educational_cess/100))
            var surcharge = 0
            if(total_amount > $scope.taxLimits.surcharge_limit){
                surcharge = (($scope.taxLimits.surcharge/100) * total_amount)
            }
            var net_tax = $window.Math.round( total_tax_projection + surcharge + educational_cess)            
            $scope.salaryTax.total_tax_projection = total_tax_projection
            $scope.total_earnings = total_earnings
            $scope.total_deductions = total_deductions
            $scope.total_amount = total_amount
            $scope.salaryTax.surcharge = surcharge
            $scope.salaryTax.educational_cess = educational_cess
            $scope.salaryTax.net_tax = net_tax
            $scope.salaryTax.balance_tax = $scope.salaryTax.net_tax - $scope.salaryTax.tax_paid
            $scope.salaryTax.balance_tax_per_remaining_months_each = $window.Math.round($scope.salaryTax.balance_tax / $scope.salaryTax.count_of_payslips_to_create_in_the_year  )
            if(!$scope.$$phase) {
                $scope.$digest()
            }
        }

        var totalEarnings = function(){
             return ($scope.salaryTax.basic+ $scope.salaryTax.hra+ $scope.salaryTax.conveyance_allowance+ $scope.salaryTax.city_compensatory_allowance+ $scope.salaryTax.special_allowance+ $scope.salaryTax.loyalty_allowance+ $scope.salaryTax.leave_settlement+ $scope.salaryTax.medical_allowance+ $scope.salaryTax.other_payment)
        }

        var totalDeductions = function(){
            return (parseInt($scope.salaryTax.final_hra_component  || 0) + parseInt($scope.salaryTax.standard_deduction || 0) + parseInt($scope.salaryTax.medical_insurances_total || 0) + parseInt($scope.salaryTax.claimed_medical_bill || 0) + parseInt($scope.salaryTax.savings_total || 0) + parseInt($scope.salaryTax.professional_tax || 0) + parseInt($scope.salaryTax.conveyance_allowance || 0) + parseInt($scope.salaryTax.atg || 0 ))
        }

        var calculateIncomeTax = function(amount){
            var tax = 0
            angular.forEach($scope.taxLimits.income_tax, function(val, key){
                if(amount >= 0){
                    if( typeof val.to != 'undefined' ){
                        var range = val.to - val.from
                        if(amount >= range ){
                            tax += (range*(val.tax/100))
                        }else{
                            tax += (amount*(val.tax/100))
                        }
                        amount = amount - range
                    }else{
                        tax += (amount*(val.tax/100))
                        amount = amount - val.from
                    }
                }
            })
            return $window.Math.round(tax)
        }

        $scope.saveSalaryTax = function(){
            salaryTaxService.createSalaryTax($scope.facultyMasterId, $scope.salaryTax)
            .then(function(response){
                if(response.data.status){
                    $window.location.href = "/faculty_masters/"+$scope.facultyMasterId+"/salary_taxes/"+response.data.id
                }else{
                    alert("Internel Error Occurred")
                }
            })
        }

        $scope.edit = function(faculty_master_id, salary_tax_id){
            $scope.facultyMasterId = faculty_master_id
            salaryTaxService.edit(faculty_master_id, salary_tax_id)
                .then(function(response){
                    $scope.salaryTax = response.data
                    initSalaryTaxLimits();
                })
        }

        $scope.updateSalaryTax = function(){
            salaryTaxService.update($scope.facultyMasterId, $scope.salaryTax)
            .then(function(response){
                if(response.data.status){
                    $window.location.href = "/faculty_masters/"+$scope.facultyMasterId+"/salary_taxes/"+$scope.salaryTax.id
                }else{
                    alert("Internel Error Occurred")
                }
            })
        }

        $scope.component_monthly_report = salaryTaxService.component_monthly_report;
        
    }]);
})(angular,  myApp);
