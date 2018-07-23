<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Contract;
use Carbon\Carbon;
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
            'charges.name as charge'
        )
            ->where('contracts.status', true)
            // ->whereRaw($number_month->month. " BETWEEN  extract(month from contracts.date_start::date) and  extract(month from contracts.date_end::date)")
            // ->whereRaw($request->year. " BETWEEN  extract(year from contracts.date_start::date) and  extract(year from contracts.date_end::date)")
            ->leftJoin('employees', 'contracts.employee_id', '=', 'employees.id')
            ->leftJoin('cities', 'cities.id', '=', 'employees.city_identity_card_id')
            ->leftJoin('management_entities', 'employees.management_entity_id', '=', 'management_entities.id')
            ->leftJoin('positions', 'contracts.position_id', '=', 'positions.id')
            ->leftJoin('charges', 'positions.charge_id', '=', 'charges.id')
            ->orderBy('employees.last_name', 'asc')
            ->orderBy('contracts.date_start', 'asc')
            ->get();
        $total = $contracts->count();
        return response()->json(['contracts' => $contracts->toArray(), 'total' => $total]);
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
