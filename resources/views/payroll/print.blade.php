<?php
  use \App\Helpers\Util;
?>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>{{ $title->name }} {{ $title->year }}</title>
        @if (Config::get('app.debug'))
            <style>
                <?php include public_path('css/all.css') ?>
            </style>
        @else
            <link rel="stylesheet" type="text/css" href="{{ asset('css/all.css') }}"></link>
        @endif
    </head>

    <body>
        <div class="header-left">
            <p>{{ $company->name }}</p>
            <p>NIT {{ $company->tax_id_number }}</p>
            <p>{{ $company->address }}</p>
        </div>

        <div class="header-right">
        @if ($company->employer_number)
            <span>No. Patronal CNS: {{ $company->employer_number }}</span>
            <span style="padding-left: 5em;"></span>
        @endif
            <span>{{ $title->report_name }}</span>
        </div>

        <div class="header-center">
            @if (!$title->consultant)
                <h2>
                    {{ implode(' - ', array_filter([$title->name, $title->subtitle, $title->management_entity, $title->position_group, $title->employer_number])) }}
                </h2>
                <h3>PERSONAL EVENTUAL - 
            @else
                <h2>
                    {{ implode(' - ', array_filter([$title->name, 'CONSULTORES EN LÍNEA'])) }}
                </h2>
                <h3>
            @endif
            MES {{ $title->month }} DE {{ $title->year }}</h3>
            <h3>(EXPRESADO EN BOLIVIANOS)</h3>
        </div>

        <div class="header-left">
            <img id="header-image" src="{{ public_path().'/images/logo.png'}}">
        </div>

        <table align="center">
            <thead>
            @if (!$title->consultant)
                <tr>
                @switch ($title->report_type)
                    @case ('H')
                        @php ($table_header_space1 = 15)
                        @php ($table_header_space2 = 6)
                        @break
                    @case ('P')
                        @php ($table_header_space1 = 9)
                        @php ($table_header_space2 = 5)
                        @break
                    @case ('T')
                        @php ($table_header_space1 = 3)
                        @php ($table_header_space2 = 1)
                        @php ($table_header_space3 = 1)
                        @php ($table_header_space4 = 4)
                        @php ($table_header_space5 = 2)
                        @php ($table_header_space6 = 3)
                        @break
                @endswitch
                    <th colspan="{{ $table_header_space1 }}" style="border-left: 1px solid white; border-top: 1px solid white; background-color: white;"></th>                    
                    <th colspan="{{ $table_header_space2 }}">{{ $title->table_header }}</th>
                    @if ($title->report_type == 'T')
                        <th colspan="{{ $table_header_space3 }}">{{ $title->table_header2 }}</th>
                        <th colspan="{{ $table_header_space4 }}" style="border-left: 1px solid white; border-top: 1px solid white; background-color: white;"></th>
                        <th colspan="{{ $table_header_space5 }}">{{ $title->table_header3 }}</th>
                        <th colspan="{{ $table_header_space6 }}">{{ $title->table_header4 }}</th>
                    @endif
                </tr>
            @endif
                <tr>
                    <th width="1%">N°</th>
                    <th width="2%">C.I.</th>
                    <th width="10%">TRABAJADOR</th>
                @if ($title->report_type == 'T')
                    <th width="2%">SUENDO NETO</th>
                    <th width="2%">Minimo No imponible</th>
                    <th width="2%">Diferencia sujeto a impuestos</th>
                    <th width="2%">Impuesto 13% Debito Fiscal</th>
                    <th width="2%">Computo IVA según D.J. Form. 110</th>
                    <th width="2%">13% Sobre 2 Min. Nal.</th>
                    <th width="2%">Fisco</th>
                    <th width="2%">Dependiente</th>
                    <th width="2%">Mes anterior</th>
                    <th width="2%">Actualización</th>
                    <th width="2%">Total</th>
                    <th width="2%">Saldo a favor del dependiente</th>
                    <th width="2%">Saldo Utilizado</th>
                    <th width="2%">Impuesto determinado a pagar</th>
                    <th width="2%">Saldo para el mes siguiente</th>
                @else
                    @if ($title->report_type == 'H')
                        @if (!$title->management_entity)
                        <th width="1%">CUENTA BANCO UNIÓN</th>
                        @endif
                        <th width="1%">FECHA NACIMIENTO</th>
                        <th width="1%">SEXO</th>
                        <th width="1%">CARGO</th>
                    @endif
                        <th width="3%">PUESTO</th>
                    @if (!$title->position_group)
                        <th width="3%">AREA</th>
                    @endif
                        <th width="4%">FECHA DE INGRESO</th>
                    @if ($title->report_type == 'H' && !$title->management_entity)
                        <th width="1%">FECHA VENCIMIENTO CONTRATO</th>
                    @endif
                        <th width="1%">DIAS TRABAJADOS</th>
                    @if ($title->report_type == 'H')
                        <th width="2%">HABER BÁSICO</th>
                    @endif
                        <th width="2%">TOTAL GANADO</th>
                        <th width="1%">AFP</th>
                    @if ($title->report_type == 'H')
                        @if (!$title->consultant)
                        <th width="1%">Renta vejez {{ $procedure->discount_old }}%</th>
                        <th width="1%">Riesgo común {{ $procedure->discount_common_risk }}%</th>
                        <th width="1%">Comisión {{ $procedure->discount_commission }}%</th>
                        <th width="1%">Aporte solidario del asegurado {{ $procedure->discount_solidary }}%</th>
                        <th width="1%">Aporte Nacional solidario 1%, 5%, 10%</th>
                        <th width="1%">TOTAL DESCUENTOS DE LEY</th>
                        <th width="3%">SUELDO NETO</th>
                        <th width="3%">RC IVA {{ $procedure->discount_rc_iva }}%</th>
                        @endif
                        <th width="3%">Desc Atrasos, Faltas y Licencia S/G Haberes</th>
                        <th width="1%">TOTAL DESCUENTOS</th>
                        <th width="3%">LIQUIDO PAGABLE</th>
                    @endif
                    @if ($title->report_type =='P')
                        <th width="1%">CNS {{ $procedure->contribution_insurance_company }}%</th>
                        <th width="1%">Riesgo Profesional {{ $procedure->contribution_professional_risk }}%</th>
                        <th width="1%">Aporte Patronal Solidario {{ $procedure->contribution_employer_solidary }}%</th>
                        <th width="1%">Aporte Patronal para Vivienda {{ $procedure->contribution_employer_housing }}%</th>
                        <th width="3%">TOTAL A PAGAR</th>
                    @endif
                @endif                
                </tr>
            </thead>
            <tbody>
                @foreach ($employees as $i => $employee)
                <tr>
                    <td>{{ ++$i }}</td>
                    <td>{{ $employee->ci_ext }}</td>
                    <td class="name">{{ $employee->full_name }}</td>
                @if ($title->report_type == 'T')
                    <td>{{ Util::format_number($employee->net_salary) }}</td>
                    @php ($min_inponible = $title->table_header2 * 2)
                    <td>{{ Util::format_number($min_inponible) }} </td>   
                    @php ($dif_impuesto = $employee->net_salary - $min_inponible)
                    @if ($dif_impuesto < 0)
                        @php ($dif_impuesto = 0)
                    @endif
                    <td>{{ Util::format_number($dif_impuesto) }} </td>
                    @php ($idf = $dif_impuesto * 13 / 100)
                    <td>{{ round($idf) }} </td>
                    <td>{{ ( $employee->discount_rc_iva > 0 )? Util::format_number($employee->discount_rc_iva) : '' }} </td>
                    @if ($employee->net_salary >= 8000)
                        @php ($sal_min_13 = $min_inponible * 13 / 100)
                    @else
                        @php ($sal_min_13 = $idf)
                    @endif
                    <td>{{ round($sal_min_13) }} </td>
                    @php ($fisco = $idf - $employee->discount_rc_iva - $sal_min_13 )
                    <td>{{ ($fisco >= 0)? round($fisco) : 0 }} </td>
                    @php ($dep = $employee->discount_rc_iva + $sal_min_13 - $idf)
                    @if ($dep < 0)
                        @php ($dep = 0)
                    @endif
                    <td>{{ round($dep) }} </td>
                @else
                    @if ($title->report_type == 'H')
                        @if (!$title->management_entity)
                        <td>{{ $employee->account_number }}</td>
                        @endif
                        <td>{{ $employee->birth_date }}</td>
                        <td>{{ $employee->gender }}</td>
                        <td>{{ $employee->charge }}</td>
                    @endif
                        <td>{{ $employee->position }}</td>
                    @if (!$title->position_group)
                        <td>{{ $employee->position_group }}</td>
                    @endif
                        <td>{{ $employee->date_start }}</td>
                    @if ($title->report_type == 'H' && !$title->management_entity)
                        <td>{{ $employee->date_end }}</td>
                    @endif
                        <td>{{ $employee->worked_days }}</td>
                    @if ($title->report_type == 'H')
                        <td>{{ Util::format_number($employee->base_wage) }}</td>
                    @endif
                        <td>{{ Util::format_number($employee->quotable) }}</td>
                        <td>{{ $employee->management_entity }}</td>
                    @if ($title->report_type == 'H')
                        @if (!$title->consultant)
                        <td>{{ Util::format_number($employee->discount_old) }}</td>
                        <td>{{ Util::format_number($employee->discount_common_risk) }}</td>
                        <td>{{ Util::format_number($employee->discount_commission) }}</td>
                        <td>{{ Util::format_number($employee->discount_solidary) }}</td>
                        <td>{{ Util::format_number($employee->discount_national) }}</td>
                        <td>{{ Util::format_number($employee->total_amount_discount_law) }}</td>
                        <td>{{ Util::format_number($employee->net_salary) }}</td>
                        <td>{{ Util::format_number($employee->discount_rc_iva) }}</td>
                        @endif
                        <td>{{ Util::format_number($employee->total_amount_discount_institution) }}</td>
                        <td>{{ Util::format_number($employee->total_discounts) }}</td>
                        <td>{{ Util::format_number($employee->payable_liquid) }}</td>
                    @endif
                    @if ($title->report_type == 'P')
                        <td>{{ Util::format_number($employee->contribution_insurance_company) }}</td>
                        <td>{{ Util::format_number($employee->contribution_professional_risk) }}</td>
                        <td>{{ Util::format_number($employee->contribution_employer_solidary) }}</td>
                        <td>{{ Util::format_number($employee->contribution_employer_housing) }}</td>
                        <td>{{ Util::format_number($employee->total_contributions) }}</td>
                    @endif
                @endif                
                </tr>
            @endforeach
                <tr class="total">
                @switch ($title->report_type)
                    @case ('H')
                        @if ($title->position_group)
                            @php ($table_footer_space1 = 9)
                        @elseif ($title->management_entity)
                            @php ($table_footer_space1 = 10)
                        @else
                            @php ($table_footer_space1 = 12)
                        @endif
                        @break
                    @case ('P')
                        @if ($title->position_group)
                            @php ($table_footer_space1 = 6)
                        @else
                            @php ($table_footer_space1 = 7)
                        @endif
                        @break
                    @case ('T')
                        @if ($title->position_group)
                            @php ($table_footer_space1 = 6)
                        @else
                            @php ($table_footer_space1 = 7)
                        @endif
                        @break
                @endswitch
                    <td class="footer" colspan="{{ $table_footer_space1 }}">TOTAL PLANILLA</td>
                @if ($title->report_type == 'H')
                    <td class="footer">{{ Util::format_number($total_discounts->base_wage) }}</td>
                    <td class="footer">{{ Util::format_number($total_discounts->quotable) }}</td>
                    <td class="footer"></td>
                    @if (!$title->consultant)
                    <td class="footer">{{ Util::format_number($total_discounts->discount_old) }}</td>
                    <td class="footer">{{ Util::format_number($total_discounts->discount_common_risk) }}</td>
                    <td class="footer">{{ Util::format_number($total_discounts->discount_commission) }}</td>
                    <td class="footer">{{ Util::format_number($total_discounts->discount_solidary) }}</td>
                    <td class="footer">{{ Util::format_number($total_discounts->discount_national) }}</td>
                    <td class="footer">{{ Util::format_number($total_discounts->total_amount_discount_law) }}</td>
                    <td class="footer">{{ Util::format_number($total_discounts->net_salary) }}</td>
                    <td class="footer">{{ Util::format_number($total_discounts->discount_rc_iva) }}</td>
                    @endif
                    <td class="footer">{{ Util::format_number($total_discounts->total_amount_discount_institution) }}</td>
                    <td class="footer">{{ Util::format_number($total_discounts->total_discounts) }}</td>
                    <td class="footer">{{ Util::format_number($total_discounts->payable_liquid) }}</td>
                @endif
                @if ($title->report_type == 'P')
                    <td class="footer">{{ Util::format_number($total_contributions->quotable) }}</td>
                    <td class="footer"></td>
                    <td class="footer">{{ Util::format_number($total_contributions->contribution_insurance_company) }}</td>
                    <td class="footer">{{ Util::format_number($total_contributions->contribution_professional_risk) }}</td>
                    <td class="footer">{{ Util::format_number($total_contributions->contribution_employer_solidary) }}</td>
                    <td class="footer">{{ Util::format_number($total_contributions->contribution_employer_housing) }}</td>
                    <td class="footer">{{ Util::format_number($total_contributions->total_contributions) }}</td>
                @endif
                </tr>
            </tbody>
        </table>
    </body>

</html>