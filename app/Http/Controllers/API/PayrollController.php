<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;
use App\Http\Controllers\Controller;
use App\Payroll;
use App\Month;
use App\Procedure;
use App\Employee;
use App\Company;
use App\Helpers\Util;

class PayrollController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $month = Month::whereRaw("lower(name) like '" . strtolower($request->month) . "'")->first();
        if (!$month) {
            return "month not found";
        }
        $procedure = Procedure::select('procedures.id')
            ->leftJoin("months", 'months.id', '=', 'procedures.month_id')
            ->whereRaw("lower(months.name) like '" . strtolower($request->month) . "'")
            ->where('year', '=', $request->year)
            ->first();
        $payrolls = Payroll::where('procedure_id', '=', $procedure->id)->get();
        foreach ($payrolls as $key => $payroll) {
            $contract = $payroll->contract;
            $position = $contract->position;
            $charge = $position->charge;
            $employee = $contract->employee;
            $payroll->contract_id = $contract->id;
            $payroll->identity_card = $employee->identity_card;
            $payroll->employee_id = $employee->id;
            $payroll->city_identity_card = $employee->city_identity_card->shortened;
            $payroll->first_name = $employee->first_name;
            $payroll->second_name = $employee->second_name;
            $payroll->surname_husband = $employee->surname_husband;
            $payroll->last_name = $employee->last_name;
            $payroll->mothers_last_name = $employee->mothers_last_name;
            $payroll->birth_date = $employee->birth_date;
            $payroll->account_number = $employee->account_number;
            $payroll->charge = $charge->name;
            $payroll->position = $position->name;
            $payroll->base_wage = $charge->base_wage;
            $payroll->management_entity = $employee->management_entity->name;
        }
        $total = $payrolls->count();
        $employees = Employee::join('contracts', 'employees.id', '=', 'contracts.employee_id')
                        ->where('contracts.status', true)
                        ->get();
        $total_employees = $employees->count();
        return response()->json(['payrolls' => $payrolls->toArray(), 'total' => $total, 'total_employees' => $total_employees]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Request $request, $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
