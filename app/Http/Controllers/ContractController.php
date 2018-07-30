<?php

namespace App\Http\Controllers;

use App\Contract;
use Illuminate\Http\Request;
use Illuminate\View\View;
use App\PositionGroup;
use App\Employee;
use App\Position;
use App\Payroll;
use App\ContractJobSchedule;
use App\ContractType;
use App\JobSchedule;
use Validator;
use Illuminate\Support\Facades\Redirect;
use App\Http\Controller\Insurance;
use App\Helpers\Util;
class ContractController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //$contracts = Contract::where('status',true)->get();
        $contracts = Contract::all();
        $data = [
            'contracts' =>  $contracts,
        ];
        return view('contract.index',$data); 
    }
    /**
     * List contracts json .
     *
     * @return \Illuminate\Http\Response
     */
    public function list($status = true)
    {
        $contracts = Contract::where('status',$status)->get();        
        foreach ($contracts as $key => $contract) {
            $row = [];
            $row[] = $contract->employee->identity_card;
            $row[] = $contract->employee->last_name.' '.$contract->employee->mothers_last_name.' '.$contract->employee->first_name.' '.$contract->employee->second_name;
            $row[] = $contract->position->name;
            $row[] = $contract->position->position_group->name;
            $row[] = date("d-m-Y", strtotime($contract->date_start));
            if(!is_null($contract->date_end)) {
                $row[] = date("d-m-Y", strtotime($contract->date_end));    
            } else {
                $row[] = '-';
            }        
            $row[] = $contract->employee->employee_type->name;
            $row[] = ($contract->status == true?'<i class="fa fa-check"></i>':'<i class="fa fa-times"></i>');
            if ( $contract->employee->employee_type_id == 3) {
                $row[] = "
                    <a class='btn btn-primary' type='button' href='contract/".$contract->id."'><i class='fa fa-eye'></i>&nbsp;Ver</a>
                    <a class='btn btn-primary' type='button' href='contract/".$contract->id."/edit'><i class='fa fa-pencil'></i>&nbsp;Editar</a>
                    <a class='btn btn-primary' type='button' href='contract/".$contract->id."/edit'><i class='fa fa-pencil'></i>&nbsp;Editar</a>
                    ";
            } else {
                $row[] = "
                    <div class='btn-group' style=''>
                        <button data-toggle='dropdown' class='btn btn-primary dropdown-toggle'>Imprimir <i class='fa fa-caret-down'></i></button>
                        <ul class='dropdown-menu bg-primary'>
                            <li>
                                <a class='dropdown-item' 
                    onclick='printJS({printable:\"".route('print_high_insurance', [$contract->id])."\", type:\"pdf\", showModal:true, modalMessage: \"Generando documento por favor espere un momento.\"})'><i class='fa fa-print'></i> Afiliacion al seguro</a>
                            </li>
                            <li>
                                <a class='dropdown-item' 
                    onclick='printJS({printable:\"".route('print_low_insurance', [$contract->id])."\", type:\"pdf\", showModal:true, modalMessage: \"Generando documento por favor espere un momento.\"})'><i class='fa fa-print'> </i>baja del asegurado</a>
                            </li>
                            <li>
                                <a class='dropdown-item'
                    onclick='printJS({printable:\"".route('print_contract', [$contract->id])."\", type:\"pdf\", showModal:true, modalMessage: \"Generando documento por favor espere un momento.\"})'><i class='fa fa-print'></i> contrato</a>
                            </li>
                        </ul>
                    </div>
                    <a class='btn btn-primary' type='button' href='contract/".$contract->id."'><i class='fa fa-eye'></i>&nbsp;Ver</a>
                    <a class='btn btn-primary' type='button' href='contract/".$contract->id."/edit'><i class='fa fa-pencil'></i>&nbsp;Editar</a>
                    <a class='btn btn-primary delete' type='button' href='#' data='".$contract->id."'><i class='fa fa-close'></i>&nbsp;Eliminar</a>
                    ";
            }
            
            $output['aaData'][] = $row;
        }        
        return response()->json($output);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $employees = Employee::where('status', true)->get();
        $position_groups = PositionGroup::get();
        $position = Position::select('positions.id', 'positions.name', 'charges.base_wage')
                                ->join('charges', 'positions.charge_id', '=', 'charges.id')
                                ->get();
        $schedules = JobSchedule::all();
        $contract_type = ContractType::all();
        $data = [
            'employees' => $employees,
            'position_groups'    =>  $position_groups,
            'position' => $position,
            'schedules' => $schedules,
            'contract_type' => $contract_type
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
        $existContract = Contract::where('employee_id', $request->employee_id)
                                    ->where('status', true)
                                    ->first();
        if($existContract) {
            return redirect('contract')->with('error', 'Este empleado ya tiene un contrato vigente');
        }
        $messages = [
            'required' => 'Campo obligatorio',
            'unique' => 'Este valor ya existe'
        ];
        $validator = Validator::make($request->all(), [
            'employee_id' => 'required',
            'position_id' => 'required',
            'date_start' => 'required',
        ],$messages);

        if ($validator->fails()) {
            return redirect('contract/create')
                        ->withErrors($validator)
                        ->withInput();
        }
        $contract = new Contract();
        $contract->employee_id = $request->employee_id;
        $contract->position_id = $request->position_id;
        $contract->date_start = $request->date_start;        
        $contract->contracts_type_id = $request->contract_type;
        if ($request->contract_type == 1) {
            $contract->date_end = $request->date_end;
        } else {
            $contract->date_end = $request->date_end;
        }
        $contract->number_contract = $request->number_contract;
        $contract->number_insurance = $request->number_insurance;
        $contract->cite_rrhh = $request->cite_rrhh;
        $contract->cite_rrhh_date = $request->cite_rrhh_date;
        $contract->numer_announcement = $request->numer_announcement;
        $contract->cite_performance = $request->cite_performance;
        $contract->description = $request->description;        
        $contract->number_contract = $request->number_contract;
        $contract->status = true;
        $contract->save();

        $schedules = JobSchedule::all();
        $sched_id = explode('|', $request->schedule);
        $contract->schedules()->attach($schedules[$sched_id[0]-1]);
        if (isset($sched_id[1])) {
            $contract->schedules()->attach($schedules[$sched_id[1]-1]);
        }
        return redirect('contract')->with('success', 'Creado correctamente');
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Contract  $contract
     * @return \Illuminate\Http\Response
     */
    public function show(Contract $contract)
    {
        $schedules = JobSchedule::all();
        $data = [
            'contract'  =>  $contract,
            'schedules' => $schedules
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
        $schedules = JobSchedule::all();
        $employee = $contract->employee;
        $position_groups = PositionGroup::get();
        $position = Position::select('positions.id', 'positions.name', 'charges.base_wage')
                                ->join('charges', 'positions.charge_id', '=', 'charges.id')
                                ->get();
        $schedules = JobSchedule::all();
        $contract_type = ContractType::all();
        $data = [
            'contract' => $contract,
            'employee' => $employee,
            'employees' => Employee::where('status', true)->get(),
            'position_groups' => $position_groups,
            'position' => $position,
            'schedules' => $schedules,
            'contract_type' => $contract_type
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
        $messages = [
            'required' => 'Campo obligatorio',
            'unique' => 'Este valor ya existe'
        ];
        $validator = Validator::make($request->all(), [
            'position_id' => 'required',
            'date_start' => 'required',
            'schedule' => 'required'
        ],$messages);

        if ($validator->fails()) {
            return redirect('contract/'.$id.'/edit')
                        ->withErrors($validator)
                        ->withInput();
        }
        $contract = Contract::find($id);
        $contract->employee_id = $contract->employee_id;
        $contract->position_id = $request->position_id;
        $contract->date_start = $request->date_start;
        $contract->contracts_type_id = $request->contract_type;
        if ($request->contract_type == 1) {
            $contract->date_end = $request->date_end;
        } else {
            $contract->date_end = $request->date_end;
        }
        $contract->date_retirement = $request->date_retirement;
        $contract->retirement_reason = $request->retirement_reason;
        $contract->number_contract = $request->number_contract;
        $contract->number_insurance = $request->number_insurance;
        $contract->cite_rrhh = $request->cite_rrhh;
        $contract->cite_rrhh_date = $request->cite_rrhh_date;
        $contract->numer_announcement = $request->numer_announcement;
        $contract->cite_performance = $request->cite_performance;
        $contract->description = $request->description;
        if ($request->status == 'on') {
            $contract->status = true;
        }else{
            $contract->status = false;
        }
        $contract->update(); 
        $schedules = JobSchedule::all();
        $sched_id = explode('|', $request->schedule);
        foreach ($contract->schedules as $key => $value) {
            $contract->schedules()->detach($value);
        }
        $contract->schedules()->attach($schedules[$sched_id[0]-1]);
        if (isset($sched_id[1])) {
            $contract->schedules()->attach($schedules[$sched_id[1]-1]);
        }
        return redirect('contract')->with('success', 'Editado correctamente');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Contract  $contract
     * @return \Illuminate\Http\Response
     */
    public function destroy(Contract $contract)
    {
        
    }
    public function delete(int $id) 
    {
        $payroll = Payroll::where('contract_id', $id)->first();
        if ($payroll == null) {
            Contract::find($id)->delete();
            return redirect('contract')->with('success', 'Eliminado correctamente');
        } else {
            return redirect('contract')->with('error', 'No se pudo eliminar');            
        }        
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
    public function checkRenovate () 
    {
        $fecha1 = strtotime ( '-10 day' , strtotime (date('Y-m-d')) ) ;
        $fecha2 = strtotime ( '+10 day' , strtotime (date('Y-m-d')) ) ;
        $contracts = Contract::whereBetween('date_end', [date ( 'Y-m-d' , $fecha1 ), date ( 'Y-m-d' , $fecha2 )])
                            ->where('status','true')
                            ->get();
        $data = [
            'contracts' =>  $contracts,
            'fecha1' => date('d-m-Y', $fecha1),
            'fecha2' => date('d-m-Y', $fecha2)
        ];
        return view('contract.renovate', $data);
    }
    public function renovate (Request $request) 
    {
        $messages = [
            'required' => 'Campo obligatorio',
        ];
        $validator = Validator::make($request->all(), [
            'date_start' => 'required',
            'date_end'  => 'required',
            'renovar'  => 'required'
        ],$messages);

        if ($validator->fails()) {
            return redirect('contract/checkrenovate')
                        ->withErrors($validator)
                        ->withInput();
        }
        $renovate = $request->renovar;
        foreach ($renovate as $value) {  
            $oldcontract = Contract::where('id',$value)->first();            
            $oldcontract->status = false;
            $oldcontract->retirement_reason = 'Conclusion de contrato';
            $oldcontract->update();

            $newcontract = new Contract();
            $newcontract->employee_id = $oldcontract->employee_id;
            $newcontract->position_id = $oldcontract->position_id;
            $newcontract->date_start = $request->date_start;
            $newcontract->date_end = $request->date_end;
            $newcontract->number_insurance = $oldcontract->number_insurance;
            $newcontract->contracts_type_id = 3;
            $newcontract->status = true;
            $newcontract->save();
        }
        return redirect('contract')->with('success', 'Contratos renovados correctamente');
    }
    public function month_salary_calculation () 
    {
        $ini = explode('-', request('date_ini'));
        $fin = explode('-', request('date_end'));
        $position = Position::find(request('position_id')); 
        
        for ($i = (int)$ini[1]; $i <= (int)$fin[1]; $i++) {
            $day = 30;
            $salary = $position->charge->base_wage;
            $salary_day = $salary / 30;
            if($i == (int)$ini[1]) {
                if((int)$ini[2] >= 30) {
                    $day = 1;
                } else {
                    $day = 30 - $ini[2] + 1;                    
                }
                $salary = $salary_day * $day;
            }
            if($i == (int)$fin[1]) {
                if((int)$fin[2] >= 30) {
                    $day = 30;    
                } else {
                    $day = (int)$fin[2];
                }
                $salary = $salary_day * $day;
            }
            if((int)$ini[1] == (int)$fin[1] && (int)$ini[0] == (int)$fin[0] ){
                if(((int)$fin[2] - (int)$ini[2]) < 30) {
                    $day = '[error]debe ser de al menos un mes';
                }
            }
            $data[] = ['month'=> Util::getMonthEs($i),'day'=>$day,'salary'=>$salary];
        }
        return $data;
    }
}
