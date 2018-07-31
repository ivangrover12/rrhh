<?php

namespace App\Http\Controllers;

use Response;
use App\Payroll;
use Illuminate\Http\Request;
use App\Employee;
use Carbon\Carbon;
use App\Discount;
use Prophecy\Promise\ReturnPromise;
use App\Procedure;
use App\Month;
use App\Contract;
use App\Company;
use App\Helpers\Util;
use Illuminate\Support\Facades\File;
use App\EmployeePayroll;
use App\TotalPayrollEmployee;
use App\TotalPayrollEmployer;
use App\ManagementEntity;
use App\PositionGroup;
use App\EmployerNumber;
use Illuminate\Support\Facades\Redirect;

class PayrollController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {        
        $procedures = Procedure::with('month')->orderBy('year', 'asc')->orderBy('month_id','desc')->get();
        $lastprocedure = Procedure::orderBy('id', 'desc')->first();
        $positions = PositionGroup::all()->groupBy('employer_number_id');
        $position_groups = [];

        foreach($positions as $i => $value) {
            if (count($value) == 1) {
                $position_groups[] = $value[0];
            }
        }

        $management_entities = ManagementEntity::all();

        $data=[
            'procedures' => $procedures,
            'position_groups' => $position_groups,
            'management_entities' => $management_entities,
            'lastprocedure' => $lastprocedure
        ];
        return view("payroll.index", $data);

    }
    public function create($year, $month)
    {
        
        $months = array_map(function ($v)
        {
            return strtolower($v);
        }, Month::pluck('name')->toArray());

        //add more validations
        if ($year <= Carbon::now()->year && in_array(strtolower($month), $months)) {
            $procedure = Procedure::select('procedures.id')->leftJoin("months", 'months.id', '=', 'procedures.month_id')->whereRaw("lower(months.name) like '" . strtolower($month) . "'")->where('year', '=', $year)->first();
            if (!$procedure) {
                return "procedure not found";
            }
            $procedure =  Procedure::with('month')->find($procedure->id);
            return view('payroll.create', compact('year', 'month', 'procedure'));
        }else {
            return 'error';
        }

    }


    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $month = Month::whereRaw("lower(name) like '" . strtolower($request->month) . "'")->first();
        if (!$month) {
            return "month not found";
        }
        $procedure = Procedure::select('procedures.id')
                                ->leftJoin("months", 'months.id', '=', 'procedures.month_id')
                                ->whereRaw("lower(months.name) like '" . strtolower($request->month)."'")
                                ->where('year', '=', $request->year)
                                ->first();                                
        if(!$procedure){
            $procedure = new Procedure();
            $procedure->month_id = $month->id;
            $procedure->year = (int)$request->year;
            $procedure->name = "planilla de ".$request->year." ".$request->month;
            $procedure->save();
        }else{
            $procedure = Procedure::find($procedure->id);
        }
        // Procedure::where('year', $request->year)->where('month', $request)
        foreach ($request->all() as $key => $value) {
            if (strpos($key, 'contract-') !== false) {
                preg_match('/\d{1,}/', $key, $matches);
                $id = (int) $matches[0];
                $contract = Contract::find($id);
                $payroll = $contract->payrolls()->where('procedure_id', $procedure->id)->first();
                if (!$payroll) {
                    $payroll = new Payroll();
                    
                    $last_payrol = Payroll::orderBy('id','DESC')->first();    
                    $year =  date('y');
                    if(!isset($last_payrol->code) || $last_payrol->code == "") {
                        $payroll->code = "1-".$year;
                    }
                    else{
                        if ($last_payrol->contract->employee_id == $contract->employee_id && $last_payrol->base_wage == $contract->position->charge->base_wage && $last_payrol->contract->position->name == $contract->position->name) {
                            $payroll->code = $last_payrol->code;
                        } else {
                            $data = explode('-', $last_payrol->code);
                            if(!isset($data[1]))
                                $payroll->code = "1-".$year;                
                            else 
                                $payroll->code = ($year!=$data[1]?"1":($data[0]+1))."-".$year;
                        }
                    }

                }
                $payroll->contract_id = $id;
                $payroll->procedure_id = $procedure->id;
                $payroll->name = "Personal Eventual - Mes ".$request->month ." de ".$request->year;
                $payroll->worked_days = $value[0];
                $payroll->unworked_days = $value[1];
                $base_wage = $contract->position->charge->base_wage ?? 1000;
                $payroll->base_wage = $base_wage;
                $quotable = ($base_wage/30)* $value[0];
                $payroll->quotable = $quotable;
                $payroll->discount_old = ($quotable * $procedure->discount_old)/100;
                $payroll->discount_common_risk = ($quotable * $procedure->discount_common_risk)/100;
                $payroll->discount_commission = ($quotable * $procedure->discount_commission)/100;
                $payroll->discount_solidary = ($quotable * $procedure->discount_solidary)/100;
                $payroll->discount_national = ($quotable * $procedure->discount_national)/100;
                $total_discount_law = (($quotable * $procedure->discount_old) / 100) + (($quotable * $procedure->discount_common_risk)/100)+(($quotable * $procedure->discount_commission)/100)+(($quotable * $procedure->discount_solidary)/100)+(($quotable * $procedure->discount_national)/100);
                $payroll->total_amount_discount_law = $total_discount_law;
                $payroll->net_salary = $quotable - $total_discount_law;
                $payroll->discount_rc_iva = floatval($value[2]);
                $payroll->discount_faults = floatval($value[3]);
                $payroll->total_amount_discount_institution = floatval($value[3]);
                $total_discounts = $total_discount_law + floatval($value[3]);
                $payroll->total_discounts = $total_discounts;
                $payroll->payable_liquid = $quotable - $total_discounts;
                $payroll->previous_month_balance = floatval($value[4]);

                $tribute = $this->tribute_calculation(($quotable - $total_discount_law), floatval($value[2]), floatval($value[4]));
                $payroll->next_month_balance = $tribute->saldo_mes_siguiente;

                $payroll->save();
            }
        }
        return redirect(url('payroll'));
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Payroll  $payroll
     * @return \Illuminate\Http\Response
     */
    public function show(Payroll $payroll)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Payroll  $payroll
     * @return \Illuminate\Http\Response
     */
    public function edit($year, $month)
    {
        $months = array_map(function ($v) {
            return strtolower($v);
        }, Month::pluck('name')->toArray());
        //add more validations
        if ($year <= Carbon::now()->year && in_array(strtolower($month), $months)) {
            $procedure = Procedure::select('procedures.id')
                ->leftJoin("months", 'months.id', '=', 'procedures.month_id')
                ->whereRaw("lower(months.name) like '" . strtolower($month) . "'")
                ->where('year', '=', $year)
                ->first();
            $procedure = Procedure::with('month')->find($procedure->id);
            return view('payroll.edit', compact('year', 'month', 'procedure'));
        } else {
            return 'error';
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Payroll  $payroll
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Payroll $payroll)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Payroll  $payroll
     * @return \Illuminate\Http\Response
     */
    public function destroy(Payroll $payroll)
    {
        //
    }

    public function employee_payroll(Employee $employee){
        return $employee;
    }

    private function generateExcelLaboral(){
        Excel::create('Filename', function($excel) {
            // Set the title
            $excel->setTitle('Our new awesome title');

            // Chain the setters
            $excel->setCreator('Maatwebsite')
                    ->setCompany('Maatwebsite');

            // Call them separately
            $excel->setDescription('A demonstration to change the file properties');
            
            $excel->sheet('Sheetname', function($sheet) {
                $center_style = array(
                    'alignment' => array(
                        'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                    )
                );


                $name = "MUTUAL DE SERVICIOS AL POLICIA";
                $nit = "NIT 234578021";
                $address = "Av. 6 De Agosto No. 2354 - Zona Sopocachi";
                $title = "PLANILLA DE HABERES";
                $subtitle = "PERSONAL EVENTUAL - MES  ABRIL DE 2018";
                $exchange = "(EXPRESADO EN BOLIVIANOS)";
                $sheet->mergeCells('A1:C1');
                $sheet->mergeCells('A2:C2');
                $sheet->mergeCells('A3:C3');

                $sheet->row(1, array(
                    $name
                ));
                $sheet->row(2, array(
                    $nit
                ));
                $sheet->row(3, array(
                    $address
                ));
                
                $objDrawing = new PHPExcel_Worksheet_Drawing;
                $objDrawing->setPath(public_path('images/logo.jpg')); //your image path
                $objDrawing->setCoordinates('E1');                
                $objDrawing->setHeight(74);                
                $objDrawing->setWorksheet($sheet);

                $sheet->mergeCells('A5:Z5');
                $sheet->getStyle("A5:Z5")->applyFromArray($center_style);
                $sheet->mergeCells('A6:Z6');
                $sheet->getStyle("A6:Z6")->applyFromArray($center_style);
                $sheet->mergeCells('A7:Z7');
                $sheet->getStyle("A7:Z7")->applyFromArray($center_style);



                $sheet->row(5, array(
                    $title
                ));
                $sheet->row(6, array(
                    $subtitle
                ));
                $sheet->row(7, array(
                    $exchange
                ));

                $row = 10;
                $sheet->getStyle($row)->getFill()
                ->setFillType(PHPExcel_Style_Fill::FILL_SOLID)
                ->getStartColor()
                ->setARGB('FF808080');
                $sheet->row($row++, array(
                    'Nº',
                    'C.I.',
                    'TRABAJADOR',
                    'SUCURSAL',
                    'CUENTA BANCO UNION',          
                    'FECHA NACIMIENTO',
                    'SEXO',
                    'CARGO',
                    'PUESTO',
                    'FECHA DE INGRESO',
                    'FECHA VENCIMIENTO CONTRATO',
                    'DIAS TRABAJADOS',
                    'HABER BASICO',
                    'TOTAL GANADO',
                    'AFP',
                    'Renta vejez 10%',
                    'Riesgo común 1,71%',
                    'Comisión 0,5%',
                    'Aporte solidario del asegurado 0,5%',
                    'Aporte Nacional solidario 1%, 5%, 10%',
                    'TOTAL DESCUENTOS DE LEY',
                    'SUELDO NETO',
                    'RC-IVA 13%',
                    'Desc. Atrasos, Abandonos, Faltas y Licencia S/G Haberes',
                    'TOTAL DESCUENTOS',
                    'LIQUIDO PAGABLE',
               ));               
               $payrolls = Payroll::get();
               $number = 1;
               foreach($payrolls as $payroll){

                $employee = $payroll->employee;
                $contract = Contract::where('employee_id',$employee->id)->where('status',true)->first();

                $sheet->row($row++, array(
                    $number++,
                    $employee->identity_card,
                    $employee->last_name.' '.$employee->mothers_last_name.' '.$employee->first_name.' '.$employee->mothers_last_name,
                    $employee->group_job??'Central',
                    $employee->account_number,
                    $employee->birth_date,
                    $employee->gender,
                    '1',
                    $employee->employee_type->name,
                    $contract->date_start,
                    $contract->date_end,
                    $payroll->worked_days,
                    $contract->base_wage,
                    $payroll->quotable,
                    $payroll->managment_entity->name,
                    $payroll->quotable*0.1,
                    $payroll->quotable*0.171,
                    $payroll->quotable*0.05,
                    0,
                    $payroll->total_amount_discount_institution,
                    $payroll->payable_liquid,
                    0,
                    $payroll->total_discounts,
                    $payroll->total_discounts,
                    $payroll->payable_liquid
                ));
               }
            });
        })->download('xls');
    }

    private function generateExcelPatronal(){
        Excel::create('Filename', function($excel) {
            // Set the title
            $excel->setTitle('Our new awesome title');

            // Chain the setters
            $excel->setCreator('Maatwebsite')
                    ->setCompany('Maatwebsite');

            // Call them separately
            $excel->setDescription('A demonstration to change the file properties');
            
            $excel->sheet('Sheetname', function($sheet) {
                $center_style = array(
                    'alignment' => array(
                        'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                    )
                );
                $name = "MUTUAL DE SERVICIOS AL POLICIA";
                $nit = "NIT 234578021";
                $address = "Av. 6 De Agosto No. 2354 - Zona Sopocachi";
                $title = "PLANILLA PATRONAL";
                $subtitle = "PERSONAL EVENTUAL - MES  ABRIL DE 2018";
                $exchange = "(EXPRESADO EN BOLIVIANOS)";
                $sheet->mergeCells('A1:C1');
                $sheet->mergeCells('A2:C2');
                $sheet->mergeCells('A3:C3');

                $sheet->row(1, array(
                    $name
                ));
                $sheet->row(2, array(
                    $nit
                ));
                $sheet->row(3, array(
                    $address
                ));
                
                $objDrawing = new PHPExcel_Worksheet_Drawing;
                $objDrawing->setPath(public_path('images/logo.jpg')); //your image path
                $objDrawing->setCoordinates('E1');                
                $objDrawing->setHeight(74);                
                $objDrawing->setWorksheet($sheet);

                $sheet->mergeCells('A5:N5');
                $sheet->getStyle("A5:N5")->applyFromArray($center_style);
                $sheet->mergeCells('A6:N6');
                $sheet->getStyle("A6:N6")->applyFromArray($center_style);
                $sheet->mergeCells('A7:N7');
                $sheet->getStyle("A7:N7")->applyFromArray($center_style);



                $sheet->row(5, array(
                    $title
                ));
                $sheet->row(6, array(
                    $subtitle
                ));
                $sheet->row(7, array(
                    $exchange
                ));

                $row = 10;
                $sheet->getStyle($row)->getFill()
                ->setFillType(PHPExcel_Style_Fill::FILL_SOLID)
                ->getStartColor()
                ->setARGB('FF808080');
                $sheet->row($row++, array(
                    'Nº',
                    'C.I.',
                    'TRABAJADOR',
                    'SUCURSAL',
                    'PUESTO',          
                    'FECHA INGRESO',
                    'TOTAL GANADO',
                    'DIAS TRABAJADOS',
                    'AFP',
                    'CNS 10%',
                    'Riesgo profesional 1,71%',
                    'Aporte Patronal Solidario 3%',
                    'Aporte patronal para vivienda 2%',
                    'TOTAL A PAGAR',                    
               ));               
               $payrolls = Payroll::get();
               $number = 1;
               foreach($payrolls as $payroll){

                $employee = $payroll->employee;
                $contract = Contract::where('employee_id',$employee->id)->where('status',true)->first();

                $sheet->row($row++, array(
                    $number++,
                    $employee->identity_card,
                    $employee->last_name.' '.$employee->mothers_last_name.' '.$employee->first_name.' '.$employee->mothers_last_name,
                    $employee->group_job->name??'Central',                                                                                
                    $employee->employee_type->name,
                    $contract->date_start,
                    $payroll->quotable,         
                    $payroll->worked_days,                    
                    $employee->management_entity->name,
                    $payroll->quotable*0.1,
                    $payroll->quotable*0.171,
                    $payroll->quotable*0.03,
                    $payroll->quotable*0.02,                    
                    $payroll->payable_liquid
                ));
               }
            });
        })->download('xls');
    }

    private function generateExcelTributaria(){
        Excel::create('Filename', function($excel) {
            // Set the title
            $excel->setTitle('Our new awesome title');

            // Chain the setters
            $excel->setCreator('Maatwebsite')
                    ->setCompany('Maatwebsite');

            // Call them separately
            $excel->setDescription('A demonstration to change the file properties');
            
            $excel->sheet('Sheetname', function($sheet) {
                $center_style = array(
                    'alignment' => array(
                        'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                    )
                );


                $name = "MUTUAL DE SERVICIOS AL POLICIA";
                $nit = "NIT 234578021";
                $address = "Av. 6 De Agosto No. 2354 - Zona Sopocachi";
                $title = "PLANILLA PATRONAL";
                $subtitle = "PERSONAL EVENTUAL - MES  ABRIL DE 2018";
                $exchange = "(EXPRESADO EN BOLIVIANOS)";
                $sheet->mergeCells('A1:C1');
                $sheet->mergeCells('A2:C2');
                $sheet->mergeCells('A3:C3');

                $sheet->row(1, array(
                    $name
                ));
                $sheet->row(2, array(
                    $nit
                ));
                $sheet->row(3, array(
                    $address
                ));
                
                $objDrawing = new PHPExcel_Worksheet_Drawing;
                $objDrawing->setPath(public_path('images/logo.jpg')); //your image path
                $objDrawing->setCoordinates('E1');                
                $objDrawing->setHeight(74);                
                $objDrawing->setWorksheet($sheet);

                $sheet->mergeCells('A5:N5');
                $sheet->getStyle("A5:N5")->applyFromArray($center_style);
                $sheet->mergeCells('A6:N6');
                $sheet->getStyle("A6:N6")->applyFromArray($center_style);
                $sheet->mergeCells('A7:N7');
                $sheet->getStyle("A7:N7")->applyFromArray($center_style);



                $sheet->row(5, array(
                    $title
                ));
                $sheet->row(6, array(
                    $subtitle
                ));
                $sheet->row(7, array(
                    $exchange
                ));

                $row = 10;
                $sheet->getStyle($row)->getFill()
                ->setFillType(PHPExcel_Style_Fill::FILL_SOLID)
                ->getStartColor()
                ->setARGB('FF808080');
                $sheet->row($row++, array(
                    'Nº',
                    'C.I.',
                    'TRABAJADOR',
                    'SUCURSAL',
                    'SUELDO NETO',          
                    'Minimo No imponible',
                    'Diferencia sujeto a impuestos',
                    'Impuesto 13% Debito Fisca',
                    'Computo IVA según D.J. Form. 110',
                    '13% Sobre 2 Min. Nal.',
                    'Fisco',
                    'Dependiente',
                    'Mes anterior',
                    'Actualizacion',
                    'Total',
                    'Saldo a favor del dependiente',
                    'Saldo Utilizado',
                    'Impuesto determinado a pagar',
                    'Saldo para mes siguiente',                    
               ));               
               $payrolls = Payroll::get();
               $number = 1;
               $basic_salary = 4000;
               $basic_salary_tax = $basic_salary*0.13;
               foreach($payrolls as $payroll){

                $employee = $payroll->employee;
                $contract = Contract::where('employee_id',$employee->id)->where('status',true)->first();
                $tax = $payroll->payable_liquid-40000>0?$payroll->payable_liquid-40000:0;
                $sheet->row($row++, array(
                    $number++,
                    $employee->identity_card,
                    $employee->last_name.' '.$employee->mothers_last_name.' '.$employee->first_name.' '.$employee->mothers_last_name,
                    $employee->group_job->name??'Central',                                                                                
                    $payroll->payable_liquid,
                    $basic_salary,
                    $tax,
                    '0',
                    $basic_salary_tax,
                    '0f',
                    '0D',
                    '0m',
                    '0A',
                    '0T',
                    '0S',
                    '0u',
                    '0I',
                    '0sig',                    
                ));
               }
            });
        })->download('xls');    
    }

    private function getFormattedData($year, $month, $valid_contracts, $consultant, $with_account, $management_entity, $position_group, $employer_number)
    {
        $procedure = Procedure::where('month_id', $month)->where('year', $year)->select()->first();

        if (isset($procedure->id)) {
            $employees = array();
            $total_discounts = new TotalPayrollEmployee();
            $total_contributions = new TotalPayrollEmployer();
            $company = Company::select()->first();

            $payrolls = Payroll::where('procedure_id', $procedure->id)->orderBy('id')->get();
            /*if (config('app.debug')) {
                $payrolls = Payroll::where('procedure_id',$procedure->id)->take(10)->orderBy('contract_id', 'ASC')->orderBy('id', 'ASC')->get();
            }*/
            foreach ($payrolls as $key => $payroll) {
                $contract = $payroll->contract;
                $employee = $contract->employee;

                $rehired = (Payroll::where('code', $payroll->code)->count() > 1) ? true : false;

                $e = new EmployeePayroll($payroll, $procedure);

                if ($rehired) {
                    $e->setValidContact(true);
                }

                if (($valid_contracts && !$e->valid_contract) || (($management_entity != 0) && ($e->management_entity_id != $management_entity)) || (($position_group != 0) && ($e->position_group_id != $position_group)) || ($employer_number && ($e->employer_number_id != $employer_number)) || (!$consultant && $e->consultant) || ($consultant && !$e->consultant) || ($with_account && !$employee->account_number)) {
                    $e->setZeroAccounts();
                } else {
                    $employees[] = $e;
                }

                $total_discounts->add_base_wage($e->base_wage);
                $total_discounts->add_quotable($e->quotable);
                $total_discounts->add_discount_old($e->discount_old);
                $total_discounts->add_discount_common_risk($e->discount_common_risk);
                $total_discounts->add_discount_commission($e->discount_commission);
                $total_discounts->add_discount_solidary($e->discount_solidary);
                $total_discounts->add_discount_national($e->discount_national);
                $total_discounts->add_total_amount_discount_law($e->total_amount_discount_law);
                $total_discounts->add_net_salary($e->net_salary);
                $total_discounts->add_discount_rc_iva($e->discount_rc_iva);
                $total_discounts->add_total_amount_discount_institution($e->total_amount_discount_institution);
                $total_discounts->add_total_discounts($e->total_discounts);
                $total_discounts->add_payable_liquid($e->payable_liquid);

                $total_contributions->add_quotable($e->quotable);
                $total_contributions->add_contribution_insurance_company($e->contribution_insurance_company);
                $total_contributions->add_contribution_professional_risk($e->contribution_professional_risk);
                $total_contributions->add_contribution_employer_solidary($e->contribution_employer_solidary);
                $total_contributions->add_contribution_employer_housing($e->contribution_employer_housing);
                $total_contributions->add_total_contributions($e->total_contributions);
            }
        } else {
            return (object)array(
                "code" => 404,
                "error" => true,
                "message" => "Planilla inexistente",
                "data" => null
            );
        }

        return (object)array(
            "code" => 200,
            "error" => false,
            "message" => "Planilla generada con éxito",
            "data" => [
                'total_discounts' => $total_discounts,
                'total_contributions' => $total_contributions,
                'employees' => $employees,
                'procedure' => $procedure,
                'company' => $company,
                'title' => (object)array(
                    'year' => $year,
                ),
            ]
        );
    }

    /**
     * Print PDF payroll reports.
     *
     * @param  integer  $year
     * @param  integer  $month
     * @param  string  $report_type
     * @param  string  $report_name
     * @param  boolean $valid_contracts
     * @param  integer  $management_entity_id
     * @param  integer  $position_group_id
     * @param  integer  $employer_number_id
     * @return \PDF
     */
    public function print_pdf(Request $params, $year, $month)
    {
        $month = Month::where('id', $month)->select()->first();
        if (!$month) {
            return response()->json([
                "error" => true,
                "message" => "Mes inexistente",
                "data" => null,
            ], 404);
        }

        $params = $params->all();

        $employer_number = 0;
        $position_group = 0;
        $management_entity = 0;
        $with_account = 0;
        $consultant = 0;
        $valid_contracts = 0;
        $report_name = '';
        $report_type = 'H';

        switch (count($params)) {
            case 8:
                $employer_number = request('employer_number');
            case 7:
                $position_group = request('position_group');
            case 6:
                $management_entity = request('management_entity');
            case 5:
                $with_account = request('with_account');
            case 4:
                $consultant = request('consultant');
            case 3:
                $valid_contracts = request('valid_contracts');
            case 2:
                $report_name = request('report_name');
            case 1:
                $report_type = strtoupper(request('report_type'));
                break;
            default:
                return response()->json([
                    'error' => true,
                    'message' => 'No se encuentra la planilla',
                    'data' => null,
                ], 404);
        }

        $response = $this->getFormattedData($year, $month->id, $valid_contracts, $consultant, $with_account, $management_entity, $position_group, $employer_number);

        $response->data['title']->subtitle = '';
        $response->data['title']->management_entity = '';
        $response->data['title']->position_group = '';
        $response->data['title']->employer_number = '';
        $response->data['title']->report_name = $report_name;
        $response->data['title']->report_type = $report_type;
        $response->data['title']->month = $month->name;
        $response->data['title']->consultant = $consultant;

        switch ($report_type) {
            case 'H':
                $response->data['title']->name = 'PLANILLA DE HABERES';
                $response->data['title']->table_header = 'DESCUENTOS DEL SISTEMA DE PENSIONES';
                break;
            case 'P':
                $response->data['title']->name = 'PLANILLA PATRONAL';
                $response->data['title']->table_header = 'APORTES PATRONALES';
                break;
            case 'T':
                $response->data['title']->name = 'PLANILLA TRIBUTARIA';
                $response->data['title']->table_header = 'S.M.N.';
                $response->data['title']->table_header2 = 2000;
                $response->data['title']->table_header3 = 'Saldo a favor de:';
                $response->data['title']->table_header4 = 'Saldo anterior a favor del dependiente';
                break;
            default:
                return response()->json([
                    'error' => true,
                    'message' => 'No se encuentra la planilla',
                    'data' => null
                ]);
        }

        if ($management_entity) {
            $response->data['title']->management_entity = ManagementEntity::find($management_entity)->name;
        }
        if ($position_group) {
            $position_group = PositionGroup::find($position_group);
            $response->data['title']->position_group = $position_group->name;
            $response->data['company']->employer_number = $position_group->employer_number->number;
        }
        if ($employer_number) {
            $employer_number = EmployerNumber::find($employer_number);
            $response->data['title']->employer_number = $employer_number->number;
            $response->data['company']->employer_number = $employer_number->number;
        }

        $file_name= implode(" ", [$response->data['title']->name, $report_name, $year, strtoupper($month->name)]).".pdf";

        // return response()->json($response, $response->code);

        return \PDF::loadView('payroll.print', $response->data)
            ->setOption('page-width', '216')
            ->setOption('page-height', '330')
            ->setOrientation('landscape')
            ->setOption('encoding', 'utf-8')
            ->setOption('footer-font-size', 5)
            ->setOption('footer-center', '[page] de [topage] - Impreso el '.date('m/d/Y H:i'))
            ->stream($file_name);
    }

    public function addmonth ()
    {
        $procedure = Procedure::orderBy('id', 'desc')->first();
        
        if ($procedure->month_id == 12) {
            $month = 1;
            $year = $procedure->year + 1;
        } else {
            $month = $procedure->month_id + 1;
            $year = $procedure->year;
        }
        if ( $month < (int)date('m') + 1 && $year <= date('Y') ) {
            $pro = new Procedure;
            $pro->month_id = $month;
            $pro->year = $year;
            $pro->name = '';  
            $pro->discount_old = 10;
            $pro->discount_common_risk = 1.71;
            $pro->discount_commission = 0.50;
            $pro->discount_solidary = 0.50;
            $pro->discount_national = 0;
            $pro->discount_rc_iva = 13;
            $pro->discount_faults = 0;
            $pro->save();
        }
        return redirect('payroll');
  }

    /**
     * Print TXT payroll reports.
     *
     * @param  integer  $year
     * @param  integer  $month
     * @return \TXT
     */
    public function print_txt($year, $month)
    {
        $month = Month::where('id', $month)->select()->first();
        if (!$month) {
            return response()->json([
                "error" => true,
                "message" => "Mes inexistente",
                "data" => null,
            ], 404);
        }

        $response = $this->getFormattedData($year, $month->id, 1, 0, 1, 0, 0, 0);
        $total_employees = count($response->data['employees']);

        if ($total_employees == 0) {
            return Redirect::back()->withErrors([
                "message" => "Todavía no se ha registrado el mes de ".$month->name
            ]);
        }

        $content = "";

        $content .= "sueldo del mes de ".strtolower($month->name)." ".$year." ".Util::fillZerosLeft(strval($total_employees), 4).Carbon::now()->format('dmY') ."\n";

        $content .= $response->data['company']->account_number.Util::fillZerosLeft(strval(Util::format_number($response->data['total_discounts']->payable_liquid, 2, '', '.')), 12)."\n";

        foreach ($response->data['employees'] as $i => $employee) {
            $content .= $employee->account_number.Util::fillZerosLeft(strval(Util::format_number($employee->payable_liquid, 2, '', '.')), 12)."1";

            if ($i < ($total_employees - 1)) {
                $content .= "\r\n";
            }
        }

        $filename = implode('_', ["sueldos", strtolower($month->name), $year]).".txt";

        $headers = ['Content-type'=>'text/plain', 'Content-Disposition'=>sprintf('attachment; filename="%s"', $filename)];

        // return response()->json($content);

        return Response::make($content, 200, $headers);

    }

    public function print_ovt($year, $month)
    {
        $month = Month::where('id', $month)->select()->first();
        if (!$month) {
            return response()->json([
                "error" => true,
                "message" => "Mes inexistente",
                "data" => null,
            ], 404);
        }

        $employees = $this->getFormattedData($year, $month->id, 0, 0, 0, 0, 0, 0)->data['employees'];
        $total_employees = count($employees);
        
        // return response()->json($employees);

        $content = "";

        $content .= implode(',', ["Nro","Tipo de documento de identidad","Número de documento de identidad","Lugar de expedición","Fecha de nacimiento","Apellido Paterno","Apellido Materno","Nombres","País de nacionalidad","Sexo","Jubilado","¿Aporta a la AFP?","¿Persona con discapacidad?","Tutor de persona con discapacidad","Fecha de ingreso","Fecha de retiro","Motivo retiro","Caja de salud","AFP a la que aporta","NUA/CUA","Sucursal o ubicación adicional","Clasificación laboral","Cargo","Modalidad de contrato","Tipo contrato","Días pagados","Horas pagadas","Haber Básico","Bono de antigüedad","Horas extra","Monto horas extra","Horas recargo nocturno","Monto horas extra nocturnas","Horas extra dominicales","Monto horas extra dominicales","Domingos trabajados","Monto domingo trabajado","Nro. dominicales","Salario dominical","Bono producción","Subsidio frontera","Otros bonos y pagos","RC-IVA","Aporte Caja Salud","Aporte AFP","Otros descuentos","\n"]);

        foreach ($employees as $i => $e) {
            $content .= implode(',', [++$i,"CI",$e->ci,$e->id_ext,$e->birth_date,$e->last_name,$e->mothers_last_name,$e->name,"BOLIVIA",$e->gender,"0","1","0","0",$e->date_start,"","",$e->ovt->insurance_company_id,$e->ovt->management_entity_id,$e->nua_cua,"1","",mb_strtoupper(str_replace(",", " ", $e->position)),$e->ovt->contract_mode,$e->ovt->contract_type,$e->worked_days,"8",round($e->quotable, 2),"0","","","","","","","","","","","","","","",round($e->discount_old, 2),round($e->total_amount_discount_law, 2),round($e->discount_faults, 2)]);

            if ($i < ($total_employees)) {
                $content .= "\n";
            }
        }

        $filename = implode('_', ["planilla", "ovt", strtolower($month->name), $year]).".csv";

        $headers = ['Content-type'=>'text/plain', 'Content-Disposition'=>sprintf('attachment; filename="%s"', $filename)];

        // return response()->json($content);

        return Response::make($content, 200, $headers);

    }
    public static function show_payroll_month ($procedure_id) 
    {
        $procedure = Procedure::find($procedure_id);
        $result = null;
        if ($procedure != null) {
            $result = Payroll::join('procedures', 'payrolls.procedure_id', '=', 'procedures.id')
                            ->join('contracts', 'payrolls.contract_id', '=', 'contracts.id')
                            ->where('procedures.month_id', $procedure->month_id )
                            ->first();
        }
        return $result;
    } 

    public static function tribute_calculation ($salary, $rciva, $mes_anterior) 
    { 
        $sal_min_nal = 2000;

        $min_disponible = $sal_min_nal * 2;        
        $dif_salario_min_disponible = $salary - $min_disponible;
        if ($dif_salario_min_disponible < 0) {
            $dif_salario_min_disponible = 0;
        }
        $idf = $dif_salario_min_disponible * 13 / 100;        
        if ($idf > 520) {
            $min_disponible_13 = 520;
        } else {
            $min_disponible_13 = $idf;
        }
        $saldo_favor = $idf - $rciva - $min_disponible_13;
        $fisco = 0;
        $dependiente = 0;
        if (($rciva - $min_disponible_13) < $idf) {
            $fisco = $idf - ($rciva + $min_disponible_13);
        }
        if (($rciva - $min_disponible_13) > $idf) {
            $dependiente = ($rciva + $min_disponible_13) -$idf;
        }  
        $saldo_mes_anterior = $mes_anterior;        
        $actualizacion = 0;
        if ($salary >= 8000) {
            $actualizacion = 1.002193919;
        }
        $total = $saldo_mes_anterior + $actualizacion;
        $saldo_favor_dependiente = $dependiente + $total;
        if ( $fisco > $saldo_favor_dependiente) {
            $saldo_utilizado = $saldo_favor_dependiente;
        } else {
            $saldo_utilizado = $fisco;
        }
        $impuesto_pagar = $fisco - $saldo_utilizado;

        $saldo_mes_siguiente = $saldo_favor_dependiente - $saldo_utilizado;
  
        $tribute['min_disponible'] = $min_disponible;
        $tribute['dif_salario_min_disponible'] = $dif_salario_min_disponible;
        $tribute['idf'] = $idf;
        $tribute['iva_110'] = $rciva;
        $tribute['min_disponible_13'] = $min_disponible_13;
        $tribute['fisco'] = $fisco;
        $tribute['dependiente'] = $dependiente;
        $tribute['saldo_mes_anterior'] = $saldo_mes_anterior;
        $tribute['actualizacion'] = $actualizacion;
        $tribute['total'] = $total;
        $tribute['saldo_favor_dependiente'] = $saldo_favor_dependiente;
        $tribute['saldo_utilizado'] = $saldo_utilizado;
        $tribute['impuesto_pagar'] = $impuesto_pagar;
        $tribute['saldo_mes_siguiente'] = $saldo_mes_siguiente;
        return (object)$tribute;
    }
}