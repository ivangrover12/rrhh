<?php

namespace App\Http\Controllers;

use App\Contract;
use Illuminate\Http\Request;
use Illuminate\View\View;
use App\PositionGroup;
use App\Employee;
class ContractController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $contracts = Contract::where('status',true)->get();
        $contracts = Contract::all();
        $data = [
            'contracts' =>  $contracts,
        ];
        return view('contract.index',$data); 
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $employees = Employee::get();
        $position_groups = PositionGroup::get();
        $data = [
            'employees' => $employees,
            'position_groups'    =>  $position_groups
        ];
        return view('contract.create',$data);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $contract = new Contract();
        $contract->employee_id = $request->employee_id;
        $contract->position_id = $request->position_id;
        $contract->date_start = $request->date_start;
        $contract->date_end = $request->date_end;
        $contract->status = true;
        $contract->save();
        return redirect('contract');
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Contract  $contract
     * @return \Illuminate\Http\Response
     */
    public function show(Contract $contract)
    {
        $data = [
            'contract'  =>  $contract
        ];
        return view('contract.show',$data);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Contract  $contract
     * @return \Illuminate\Http\Response
     */
    public function edit(Contract $contract)
    {
        $employee = $contract->employee;
        $position_groups = PositionGroup::get();
        $data = [
            'contract' => $contract,
            'employee' => $employee,
            'employees' => Employee::all(),
            'position_groups' => $position_groups
        ];
        return view('contract.edit',$data);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Contract  $contract
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $contract = Contract::find($id);
        $contract->employee_id = $contract->employee_id;
        $contract->position_id = $request->position_id;
        $contract->date_start = $request->date_start;
        $contract->date_end = $request->date_end;

        $contract->number_insurance = $request->number_insurance;
        $contract->number_contract = $request->number_contract;
        $contract->cite_rrhh = $request->cite_rrhh;
        $contract->cite_rrhh_date = $request->cite_rrhh_date;
        $contract->numer_announcement = $request->numer_announcement;

        if ($request->status == 'on') {
            $contract->status = true;
        }else{
            $contract->status = false;
        }
        $contract->save();
        return redirect('contract');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Contract  $contract
     * @return \Illuminate\Http\Response
     */
    public function destroy(Contract $contract)
    {
        //
    }
    public function print(int $id)
    { 
        $contract = Contract::where('id',$id)->first();
        
        $meses = ['','Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];        
        $file_name= "Seguro.pdf";
        $data = [
            'contract' => $contract,
            'mae' => Contract::where([['position_id', '=', '1'],['status', '=', 'true'],])->first(),
            'daa' => Contract::where([['position_id', '=', '53'],['status', '=', 'true'],])->first()
        ];
        $headerHtml = view()->make('partials.head')->render();
        if ($contract->employee->employee_type_id == 3) {
            return \PDF::loadView('contract.printConsultor',$data)
            ->setOption('header-html', $headerHtml)
            ->setPaper('legal')
            ->setOption('margin-top', 30)
            ->setOption('margin-bottom', 40)
            ->setOption('margin-left', 30)
            ->setOption('margin-right', 25)
            ->setOption('encoding', 'utf-8')
            ->stream($file_name);
        } else {
            return \PDF::loadView('contract.printEventual',$data)
            ->setOption('header-html', $headerHtml)
            ->setPaper('legal')
            ->setOption('margin-top', 30)
            ->setOption('margin-bottom', 40)
            ->setOption('margin-left', 30)
            ->setOption('margin-right', 25)
            ->setOption('encoding', 'utf-8')
            ->stream($file_name);
        }        
    }
    public function header()
    {
        echo 'aaaa';die;
    }
}
