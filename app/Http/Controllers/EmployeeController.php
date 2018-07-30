<?php

namespace App\Http\Controllers;

use App\Employee;
use Illuminate\Http\Request;
use App\City;
use App\EmployeeType;
use Validator;
use App\Exports\PayrollExport;
use Excel;
use App\Payroll;
use PHPExcel_Worksheet_Drawing;
use PHPExcel_Style_Alignment;
use PHPExcel_Style_Fill;
use App\Contract;
use App\Position;
use App\DiscountPayroll;
use App\InsuranceCompany;
use App\ManagementEntity;
class EmployeeController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $employees = Employee::get();
        $data = [
            'employees' => $employees,
        ];
        return view('employee.index',$data);
    }
    public function list()
    {
        $employees = Employee::get();        
        foreach ($employees as $key => $employee) {
            $row = [];
            $row[] = $key+1;
            $row[] = $employee->identity_card.' '.$employee->city_identity_card->shortened;
            $row[] = $employee->last_name;
            $row[] = $employee->mothers_last_name;
            $row[] = $employee->first_name;
            $row[] = $employee->second_name; 
            $row[] = date("d-m-Y", strtotime($employee->birth_date));
            $row[] = $employee->account_number;
            $row[] = $employee->nua_cua;
            $row[] = $employee->management_entity->name;
            $row[] = $employee->employee_type->name;
            if ($employee->status == true) {
                $checked = 'checked';
            } else {
                $checked = '';
            }
            $row[] = '
                    <div class="switch">
                        <div class="onoffswitch">
                            <input type="checkbox" '.$checked.' class="onoffswitch-checkbox status" id="example1" value="'.$employee->id.'" >
                            <label class="onoffswitch-label" for="example1">
                                <span class="onoffswitch-inner"></span>
                                <span class="onoffswitch-switch"></span>
                            </label>
                        </div>
                    </div>';
            $row[] = '
                    <a class="btn btn-primary" type="button" href="employee/'.$employee->id.'"><i class="fa fa-check-circle"></i>&nbsp;Ver</a>
                    <a class="btn btn-primary" type="button" href="employee/'.$employee->id.'/edit"><i class="fa fa-check-circle"></i>&nbsp;Editar</a>                    
                    ';
            $output['aaData'][] = $row;
        }        
        return response()->json($output);
    }

    public function getEmployeeDatatable(){

        // $users = Employee::select(['id','first_name','last_name','created_at','updated_at']);

        // return Datatables::of($users)->make();

        $employees - Employee::get();
        return Datatables::of($employees)
            ->addColumn('action', function ($u) {
                return '<a href="/user/' . $u->id . '/edit" class="btn btn-xs btn-primary"><i class="glyphicon glyphicon-edit"></i>Edit</a>';
            })
            ->editColumn('first_name', function ($u) {
                return $u->first_name ?? "";
            })
            ->editColumn('second_name', function ($u) {
                return $u->second_name . ' ' . $u->second_name?? "";
            })            
            ->editColumn('last_name', function ($u) {
                return $u->second_name . ' ' . $u->second_name?? "";
            })            
            ->editColumn('mothers_last_name', function ($u) {
                return $u->second_name . ' ' . $u->second_name?? "";
            })            
            ->editColumn('identity_card', function ($u) {
                return $u->second_name . ' ' . $u->second_name?? "";
            })                        
            // ->addColumn('state', function($u) {
            //     return '<a class="btn btn-xs btn-primary"><i class="fa fa-arrow-circle-up"></i> Cambiar</a>';
            //     })->rawColumns(['state','action','button-roles'])
            ->make(true);

    }
    public function getEmployees(){
        $offset = $request->offset ?? 0;
        $limit = $request->limit ?? 10;
        $sort = $request->sort ?? 'id';
        $order = $request->order ?? 'ASC';
        $last_name = strtoupper($request->last_name) ?? '';
        $mothers_last_name = strtoupper($request->mothers_last_name) ?? '';
        $first_name = strtoupper($request->first_name) ?? '';
        $second_name = strtoupper($request->second_name) ?? '';                
        $identity_card = strtoupper($request->identity_card) ?? '';
        $total = 100;

        $employees = Employee::select(
            'employees.id',
            'employees.identity_card',
            'employees.first_name',
            'employees.second_name',
            'employees.last_name',
            'employees.mothers_last_name',
            'employee_types.name as employee_type'
        )
        ->leftJoin('employee_types','employees.employee_type_id','=','employee_types.id')        
        ->skip($offset)
        ->take($limit)
        ->orderBy($sort,$order)
        ->get();
        
        $data = [
            'employees' => $employees, 
            'total' =>  $total
        ];
        return response()->json($data);

    }
    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $cities = City::get();
        $employee_types = EmployeeType::get();
        $insurance_company = InsuranceCompany::get();
        $management_entity = ManagementEntity::get();
        $data = [
            'cities'  =>  $cities,
            'employee_types' =>  $employee_types,
            'insurances' =>  $insurance_company,
            'managements'    =>  $management_entity,
        ];
        return view('employee.create',$data);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $messages = [
            'required' => 'Campo obligatorio',
            'unique' => 'Este valor ya existe'
        ];
        $validator = Validator::make($request->all(), [
            'identity_card' => 'required|unique:employees',
            'first_name'    =>  'required',
        ],$messages);

        if ($validator->fails()) {
            return redirect('employee/create')
                        ->withErrors($validator)
                        ->withInput();
        }    
        $employee = new Employee();
        $employee->employee_type_id = $request->employee_type_id;
        $employee->city_identity_card_id = $request->city_identity_card_id;
        $employee->city_birth_id = $request->city_birth_id;
        $employee->first_name = $request->first_name;
        $employee->second_name = $request->second_name; 
        $employee->last_name = $request->last_name;
        $employee->mothers_last_name = $request->mothers_last_name; 
        $employee->identity_card = $request->identity_card; 
        $employee->birth_date = $request->birth_date;
        $employee->account_number = $request->account_number;
        $employee->gender = $request->gender;
        $employee->management_entity_id = $request->management_entity_id;
        $employee->insurance_company_id = $request->insurance_company_id;
        $employee->nua_cua = $request->nua_cua;
        $employee->location = $request->location;
        $employee->zone = $request->zone;
        $employee->street = $request->street;
        $employee->number = $request->number;
        $employee->save();
        return redirect('employee')->with('success', 'Creado correctamente');
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Employee  $employee
     * @return \Illuminate\Http\Response
     */
    public function show(Employee $employee)
    {
        $cities = City::get();
        $employee_types = EmployeeType::get();
        $insurance_company = InsuranceCompany::get();
        $management_entity = ManagementEntity::get();
        $data = [
            'employee'  =>  $employee,
            'cities'  =>  $cities,
            'employee_types' =>  $employee_types,
            'insurances' =>  $insurance_company,
            'managements'    =>  $management_entity,
        ];
        return view('employee.show',$data);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Employee  $employee
     * @return \Illuminate\Http\Response
     */
    public function edit(Employee $employee)
    {
        $cities = City::get();
        $employee_types = EmployeeType::get();
        $insurance_company = InsuranceCompany::get();
        $management_entity = ManagementEntity::get();
        $data = [
            'employee'  =>  $employee,
            'cities'  =>  $cities,
            'employee_types' =>  $employee_types,
            'insurances' =>  $insurance_company,
            'managements'    =>  $management_entity,
        ];        
        return view('employee.edit', $data);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Employee  $employee
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Employee $employee)
    {   
        $messages = [
            'required' => 'Campo obligatorio',
            'unique' => 'Este valor ya existe'
        ];
        $validator = Validator::make($request->all(), [
            'identity_card' => 'required|unique:employees,identity_card,' . $employee->id,
            'first_name'    =>  'required',
        ],$messages);

        if ($validator->fails()) {
            return redirect(asset('employee/'.$employee->id.'/edit'))
                    ->withErrors($validator)
                    ->withInput();
        }     
        
        $employee->employee_type_id = $request->employee_type_id;
        $employee->city_identity_card_id = $request->city_identity_card_id;
        $employee->city_birth_id = $request->city_birth_id;
        $employee->first_name = $request->first_name;
        $employee->second_name = $request->second_name; 
        $employee->last_name = $request->last_name;
        $employee->mothers_last_name = $request->mothers_last_name; 
        $employee->identity_card = $request->identity_card; 
        $employee->birth_date = $request->birth_date;
        $employee->account_number = $request->account_number;
        $employee->gender = $request->gender;
        $employee->management_entity_id = $request->management_entity_id;
        $employee->insurance_company_id = $request->insurance_company_id;
        $employee->nua_cua = $request->nua_cua;
        $employee->location = $request->location;
        $employee->zone = $request->zone;
        $employee->street = $request->street;
        $employee->number = $request->number;
        $employee->save();
        return redirect('employee')->with('success', 'Editado correctamente');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Employee  $employee
     * @return \Illuminate\Http\Response
     */
    public function destroy(Employee $employee)
    {
        //
    }
    public function status(int $id) 
    {
        $employee = Employee::find($id);
        if ($employee->status == true) {            
            $employee->status = false;
        } else {
            $employee->status = true;
        }
        $employee->update();
    }
}
