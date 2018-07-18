<?php

namespace App;

use Carbon\Carbon;
use App\Helpers\Util;

class EmployeePayroll
{
    function __construct($payroll, $procedure)
    {
        $contract = $payroll->contract;
        $employee = $contract->employee;

        // Common data
        $this->nua_cua = $employee->nua_cua;
        $this->ci = $employee->identity_card;
        $this->id_ext = $employee->city_identity_card->shortened;
        $this->insurance_company_id = $employee->insurance_company_id;
        $this->ci_ext = Util::ciExt($employee);
        $this->name = implode(" ", [$employee->first_name, $employee->second_name]);
        $this->last_name = $employee->last_name;
        $this->mothers_last_name = $employee->mothers_last_name;
        $this->full_name = Util::fullName($employee, 'uppercase', 'lastname_first');
        $this->consultant = ($employee->employee_type->name == 'Consultor') ? true : false;
        $this->account_number = $employee->account_number;
        $this->birth_date = Util::getDate($employee->birth_date);
        $this->gender = $employee->gender;
        $this->charge = $contract->position->charge->name;
        $this->position = $contract->position->name;
        $this->date_start = Util::getDate($contract->date_start);
        $this->date_end = is_null($contract->date_end) ? 'Indefinido' : Util::getDate($contract->date_end);
        $this->base_wage = $payroll->base_wage;
        $this->management_entity = $employee->management_entity->name;
        $this->management_entity_id = $employee->management_entity->id;
        $this->worked_days = $payroll->worked_days;

        // Payable template
        $this->discount_old = null;
        $this->discount_common_risk = null;
        $this->discount_commission = null;
        $this->discount_solidary = null;
        $this->discount_national = null;
        $this->total_amount_discount_law = null;
        $this->net_salary = null;
        $this->discount_rc_iva = null;
        $this->total_amount_discount_institution = null;
        $this->total_discounts = null;
        $this->payable_liquid = null;
        $this->employeeDiscounts($payroll, $procedure);

        // Employer template
        $this->contribution_insurance_company = null;
        $this->contribution_professional_risk = null;
        $this->contribution_employer_solidary = null;
        $this->contribution_employer_housing = null;
        $this->total_contributions = null;
        $this->employerContribution($procedure);

        // Extra data
        $this->position_group = $contract->position->position_group->name;
        $this->position_group_id = $contract->position->position_group->id;
        $this->employer_number = $contract->position->position_group->employer_number->number;
        $this->employer_number_id = $contract->position->position_group->employer_number->id;
        $this->valid_contract = (is_null($contract->date_end) && $contract->status) ? true : (Carbon::parse($contract->date_end)->gte(Carbon::create($procedure->year, $procedure->month->id)->endOfMonth()) || Carbon::parse($contract->date_end)->gte(Carbon::create($procedure->year, $procedure->month->id, 30)) && $contract->status);
    }

    public function setZeroAccounts() {
        $this->base_wage = 0;
        $this->quotable = 0;
        $this->discount_old = 0;
        $this->discount_common_risk = 0;
        $this->discount_commission = 0;
        $this->discount_solidary = 0;
        $this->discount_national = 0;
        $this->total_amount_discount_law = 0;
        $this->discount_commission = 0;
        $this->net_salary = 0;
        $this->discount_rc_iva = 0;
        $this->total_amount_discount_institution = 0;
        $this->total_discounts = 0;
        $this->total_amount_discount_institution = 0;
        $this->payable_liquid = 0;
        $this->contribution_insurance_company = 0;
        $this->contribution_professional_risk = 0;
        $this->contribution_employer_solidary = 0;
        $this->contribution_employer_housing = 0;
        $this->total_contributions = 0;
    }

    private function employeeDiscounts($payroll, $procedure)
    {
        $this->quotable = $this->base_wage * $this->worked_days / 30;
        $this->discount_old = Util::get_percentage($this->quotable, $procedure->discount_old);
        $this->discount_common_risk = Util::get_percentage($this->quotable,$procedure->discount_common_risk);
        $this->discount_commission = Util::get_percentage($this->quotable,$procedure->discount_commission);
        $this->discount_solidary = Util::get_percentage($this->quotable, $procedure->discount_solidary);
        $this->discount_national = Util::get_percentage($this->quotable, $procedure->discount_national);
        $this->total_amount_discount_law = $this->discount_old + $this->discount_common_risk + $this->discount_commission + $this->discount_solidary + $this->discount_national;
        $this->net_salary = $this->quotable - $this->total_amount_discount_law;
        $this->discount_rc_iva = $payroll->discount_rc_iva;
        $this->total_amount_discount_institution = $payroll->total_amount_discount_institution;
        $this->total_discounts = $this->total_amount_discount_law + $this->total_amount_discount_institution + $this->discount_rc_iva;
        $this->payable_liquid = round(($this->quotable - $this->total_discounts), 2);
    }

    private function employerContribution($procedure)
    {
        $this->contribution_insurance_company = Util::get_percentage($this->quotable, $procedure->contribution_insurance_company);
        $this->contribution_professional_risk = Util::get_percentage($this->quotable, $procedure->contribution_professional_risk);
        $this->contribution_employer_solidary = Util::get_percentage($this->quotable, $procedure->contribution_employer_solidary);
        $this->contribution_employer_housing = Util::get_percentage($this->quotable, $procedure->contribution_employer_housing);
        $this->total_contributions = round(($this->contribution_insurance_company + $this->contribution_professional_risk + $this->contribution_employer_solidary + $this->contribution_employer_housing), 2);
    }

    public function setWorkedDays($worked_days, $payroll, $procedure)
    {
        $this->worked_days = $worked_days;
        $this->employeeDiscounts($payroll, $procedure);
        $this->employerContribution($procedure);
    }

    public function setValidContact($valid_contract)
    {
        $this->valid_contract = $valid_contract;
    }
}