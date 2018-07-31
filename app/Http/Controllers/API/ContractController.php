<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Carbon\Carbon;
use App\Contract;
use App\Employee;
use App\Procedure;
use App\Month;
use App\Helpers\Util;

class ContractController extends Controller
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

        $aux_month = $month->id -1;
        $aux_year = $request->year;
        if ($aux_month == 0) {
            $aux_month = 12;
            $aux_year = $request->year -1;
        }
        $previousProcedure = Procedure::where('month_id', $aux_month)->where('year', $aux_year)->first();
        $previousProcedureId = $previousProcedure->id;

        $number_month = Util::geMonth($month->name);
        $offset = $request->offset ?? 0;
        $limit = $request->limit ?? 10;
        $sort = $request->sort ?? 'id';
        $order = $request->order ?? 'asc';
        $last_name = strtoupper($request->last_name) ?? '';
        $first_name = strtoupper($request->first_name) ?? '';
        $second_name = strtoupper($request->second_name) ?? '';
        $mothers_last_name = strtoupper($request->mothers_last_name) ?? '';
        $surname_husband = strtoupper($request->surname_husband) ?? '';
        $identity_card = strtoupper($request->identity_card) ?? '';
        $request_date = Carbon::create($request->year, $month->id, 1);
        $contracts = Contract::select(
            'contracts.id',
            'contracts.date_start',
            'contracts.date_end',
            'employees.id as employee_id',
            'employees.identity_card',
            'cities.shortened as city_identity_card',
            'employees.first_name',
            'employees.second_name',
            'employees.surname_husband',
            'employees.last_name',
            'employees.mothers_last_name',
            'employees.account_number',
            'employees.birth_date',
            'management_entities.name as management_entity',
            'positions.name as position',
            'charges.base_wage',
            'charges.name as charge',
            'payrolls.next_month_balance'
        )
        ->where('contracts.contracts_type_id', '!=', 4) //TODO cambiar por name=Consultor en contract_types
        ->where(function ($query) use ($request_date) {
            $query
            ->orWhere(function ($q) use ($request_date) {
                $q
                ->whereNull('contracts.date_retirement')
                ->whereNull('contracts.date_end')
                ->whereDate('contracts.date_start', '<=', $request_date->format('Y-m-d'));
            })
            ->orWhere(function ($q) use ($request_date) {
                $q
                ->whereNotNull('contracts.date_retirement')
                ->whereYear('contracts.date_retirement', $request_date->year)
                ->whereMonth('contracts.date_retirement', $request_date->month);
            })
            ->orWhere(function ($q) use ($request_date) {
                $q
                ->whereNull('contracts.date_retirement')
                ->whereDate('contracts.date_end', '>=', $request_date->format('Y-m-d'))
                ->whereDate('contracts.date_start', '<', $request_date->format('Y-m-d'));
            })
            ->orWhere(function ($q) use ($request_date) {
                $q
                ->whereNull('contracts.date_retirement')
                ->whereYear('contracts.date_start', $request_date->year)
                ->whereMonth('contracts.date_start', $request_date->month);
            });
        })
        ->leftJoin('employees', 'contracts.employee_id', '=', 'employees.id')
        ->leftJoin('cities', 'cities.id', '=', 'employees.city_identity_card_id')
        ->leftJoin('management_entities', 'employees.management_entity_id', '=', 'management_entities.id')
        ->leftJoin('positions', 'contracts.position_id', '=', 'positions.id')
        ->leftJoin('charges', 'positions.charge_id', '=', 'charges.id')
        /*   Mes anterior   */
        ->leftJoin('payrolls', function ($join) use($previousProcedureId) {
            $join->on('payrolls.contract_id', '=', 'contracts.id')
            ->where('payrolls.procedure_id','=', $previousProcedureId);
        })
        /* ---- */
        ->orderBy('employees.last_name')
        ->orderBy('employees.id')
        ->orderBy('contracts.date_start')
        ->get();
        $total_contracts = $contracts->count();
        $employees = Employee::join('contracts', 'employees.id', '=', 'contracts.employee_id')
                        ->where('contracts.status', true)
                        ->get();
        $total_employees = $employees->count();
        return response()->json(['contracts' => $contracts->toArray(), 'total' => $total_contracts, 'total_employees' => $total_employees]);
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
    public function show($id)
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
