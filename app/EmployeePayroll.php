<?php

namespace App;

use App\Helpers\Util;
use Carbon\Carbon;

class EmployeePayroll
{
    public function __construct($payroll)
    {
        $contract = $payroll->contract;
        $employee = $contract->employee;

        // Common data
        $this->employee_id = $employee->id;
        $this->month_id = $payroll->procedure->month_id;
        $this->payroll_id = $payroll->id;
        $this->previous_month_balance = $payroll->previous_month_balance;
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
        $this->date_retirement = is_null($contract->date_retirement) ? null : Util::getDate($contract->date_retirement);
        $this->base_wage = $payroll->base_wage;
        $this->management_entity = $employee->management_entity->name;
        $this->management_entity_id = $employee->management_entity->id;
        $this->unworked_days = $payroll->unworked_days;
        $this->worked_days = $this->worked_days($payroll);
        $this->ovt = (object) [
            'insurance_company_id' => $employee->insurance_company->ovt_id,
            'management_entity_id' => $employee->management_entity->ovt_id,
            'contract_mode' => $employee->lastContract()->ovt_contract_mode,
            'contract_type' => $employee->lastContract()->ovt_contract_type,
        ];

        // Payable template
        $this->discount_old = null;
        $this->discount_common_risk = null;
        $this->discount_commission = null;
        $this->discount_solidary = null;
        $this->discount_national = null;
        $this->total_amount_discount_law = null;
        $this->net_salary = null;
        $this->discount_rc_iva = null;
        $this->discount_faults = null;
        $this->total_amount_discount_institution = null;
        $this->total_discounts = null;
        $this->payable_liquid = null;
        $this->employeeDiscounts($payroll);

        // Employer template
        $this->contribution_insurance_company = null;
        $this->contribution_professional_risk = null;
        $this->contribution_employer_solidary = null;
        $this->contribution_employer_housing = null;
        $this->total_contributions = null;
        $this->employerContribution($payroll);

        // Extra data
        $this->position_group = $contract->position->position_group->name;
        $this->position_group_id = $contract->position->position_group->id;
        $this->employer_number = $contract->position->position_group->employer_number->number;
        $this->employer_number_id = $contract->position->position_group->employer_number->id;
        $this->valid_contract = (is_null($contract->date_end) || $contract->status) ? true : (Carbon::parse($contract->date_end)->gte(Carbon::create($payroll->procedure->year, $payroll->procedure->month->id)->endOfMonth()) || Carbon::parse($contract->date_end)->gte(Carbon::create($payroll->procedure->year, $payroll->procedure->month->id, 30)) || $contract->status);
    }

    public function setZeroAccounts()
    {
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
        $this->discount_faults = 0;
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

    private function employeeDiscounts($payroll)
    {
        $this->quotable = $this->base_wage * $this->worked_days / 30;
        $this->discount_old = Util::get_percentage($this->quotable, $payroll->procedure->discount_old);
        $this->discount_common_risk = Util::get_percentage($this->quotable, $payroll->procedure->discount_common_risk);
        $this->discount_commission = Util::get_percentage($this->quotable, $payroll->procedure->discount_commission);
        $this->discount_solidary = Util::get_percentage($this->quotable, $payroll->procedure->discount_solidary);
        $this->discount_national = Util::get_percentage($this->quotable, $payroll->procedure->discount_national);
        $this->total_amount_discount_law = $this->discount_old + $this->discount_common_risk + $this->discount_commission + $this->discount_solidary + $this->discount_national;
        $this->net_salary = $this->quotable - $this->total_amount_discount_law;
        $this->discount_rc_iva = $payroll->discount_rc_iva;
        $this->discount_faults = $payroll->discount_faults;
        $this->total_amount_discount_institution = $payroll->total_amount_discount_institution;
        $this->total_discounts = $this->total_amount_discount_law + $this->discount_faults;
        $this->payable_liquid = round(($this->quotable - $this->total_discounts), 2);
    }

    private function employerContribution($payroll)
    {
        if ($payroll->contract->employee->insurance_company->active) {
            $this->contribution_insurance_company = Util::get_percentage($this->quotable, $payroll->procedure->contribution_insurance_company);
        }
        $this->contribution_professional_risk = Util::get_percentage($this->quotable, $payroll->procedure->contribution_professional_risk);
        $this->contribution_employer_solidary = Util::get_percentage($this->quotable, $payroll->procedure->contribution_employer_solidary);
        $this->contribution_employer_housing = Util::get_percentage($this->quotable, $payroll->procedure->contribution_employer_housing);
        $this->total_contributions = round(($this->contribution_insurance_company + $this->contribution_professional_risk + $this->contribution_employer_solidary + $this->contribution_employer_housing), 2);
    }

    public function setWorked_days($worked_days, $payroll)
    {
        $this->worked_days = $worked_days;
        $this->employeeDiscounts($payroll);
        $this->employerContribution($payroll);
    }

    public function getWorked_days()
    {
        return $this->worked_days;
    }

    public function setValidContact($valid_contract)
    {
        $this->valid_contract = $valid_contract;
    }

    private function worked_days($payroll)
    {
        $contract = $payroll->contract;

        $payroll_date = (object) [
            "year" => $payroll->procedure->year,
            "month" => $payroll->procedure->month_id,
        ];

        $date_start = Carbon::parse($contract->date_start);

        $date_end = Carbon::parse($contract->date_end);

        if ($this->date_retirement != null) {
            $date_retirement = Carbon::parse($contract->date_retirement);
            if ($date_retirement->year == $payroll_date->year && $date_retirement->month == $payroll_date->month) {
                $date_end = $date_retirement;
            }
        }

        $last_day_of_month = Carbon::create($payroll_date->year, $payroll_date->month)->endOfMonth()->day;
        $worked_days = 0;

        if ($contract->date_end == null) {
            $worked_days = 30;
        } else if ($date_start->year == $date_end->year && $date_start->month == $date_end->month) {
            if ($date_end->day == $last_day_of_month && ($last_day_of_month < 30 || $last_day_of_month > 30)) {
                $worked_days = 30 - $date_start->day + 1;
            } else {
                $worked_days = $date_end->day - $date_start->day;
            }
            $worked_days += 1;
        } elseif ($date_start->year <= $payroll_date->year && $date_start->month == $payroll_date->month) {
            $worked_days = 30 - $date_start->day + 1;
        } elseif ($date_end->year >= $payroll_date->year && $date_end->month == $payroll_date->month) {
            $worked_days = $date_end->day;
        } elseif (($date_start->year <= $payroll_date->year && $date_start->month < $payroll_date->month) || ($date_end->year >= $payroll_date->year && $date_end->month > $payroll_date->month)) {
            $worked_days = 30;
        } else {
            $worked_days = 0;
        }
        if ($payroll->unworked_days > $worked_days) {
            return 0;
        } else {
            return ($worked_days - $payroll->unworked_days);
        }
    }
}
