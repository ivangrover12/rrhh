<?php
namespace App\Exports;

use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\FromArray;
use Maatwebsite\Excel\Concerns\WithHeadings;
use App\Employee;
use App\Payroll;
use App\Contract;
use Excel;
use DB;
class PayrollExport implements FromCollection, WithHeadings
{
    public function collection()
    {
        
        // return $employees = Employee::select(
        //     DB::raw('ROW_NUMBER() OVER(ORDER BY employees.ID DESC) AS Row'),
        //     'employees.identity_card',
        //     DB::raw("CONCAT(employees.last_name,' ',employees.mothers_last_name,' ',employees.first_name,' ',employees.second_name) AS worker"),
        //     'employees.account_number',
        //     'employees.birth_date',
        //     'employees.gender',
        //     'employee_types.name',
        //     'charges.name',
        //     'contracts.date_start',
        //     'contracts.date_end'
        //     )
        //     ->leftJoin('contracts','employees.id','=','contracts.employee_id')
        //     ->leftJoin('charges','employees.id','=','charges.employee_id')
        //     ->leftJoin('employee_types','employees.employee_type_id','=','employee_types.id')
        //     ->groupBy('identity_card')
        //     ->get();
        $payrolls = Payroll::get();
        $collection = collect();

        $result = [];
        $i = 1;
        foreach($payrolls as $payroll){
            $employee = $payroll->employee;
            $contract = Contract::where('employee_id',$employee->id)->where('status',true)->first();
            $row = [
                'number'    =>  $i,
                'CI'    =>  $employee->identity_card,
                'worker'    =>  $employee->last_name.' '.$employee->mothers_last_name.' '.$employee->first_name.' '.$employee->mothers_last_name,
                'acccont_number'    =>  $employee->account_number,
                'birth_date'    =>  $employee->birth_date,
                'gender'    =>  $employee->gender,
                'charge'    =>  '1',
                'employee_type' =>  $employee->employee_type->name,
                'start_date'    =>  $contract->date_start,
                'end_date'    =>  $contract->date_end,
                'work_days' =>  $payroll->worked_days,
                'unworked_days' =>  $payroll->unworked_days,
                'base_wage' =>  $contract->base_wage,
                'quotable'  =>  $payroll->quotable,
                'afp'   =>  '1',
                'rent'  =>  $payroll->quotable*0.1,
                'commision' =>  $payroll->quotable*0.05,
                'risk' =>  $payroll->quotable*0.171,
                'solidary_apport'   =>  $payroll->quotable*0.05,
                'national_apport'   =>  0,
                'total_lay_discount'    =>  $payroll->total_amount_discount_institution,
                'net_salary'    =>  $payroll->payable_liquid,
                'rc_iva'    =>  0,
                'discounts' =>  $payroll->total_discounts,
                'total_discounts' =>  $payroll->total_discounts,
                'liquid_payable'    => $payroll->payable_liquid
            ];
            $collection->offsetSet($i++, $row);
            //array_push($result,$row);
        }
        
        
        return $collection;
    }

    

    public function headings(): array
    {
        return [            
            'Nº',
            'C.I.',
            'TRABAJADOR',
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
        ];
    }
}
?>
