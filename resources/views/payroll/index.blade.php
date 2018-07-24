@extends('layouts.app') 
@section('content')
<?php
    use \App\Http\Controllers\PayrollController as Payroll;
?>
<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-9">
        {{ Breadcrumbs::render('payroll_index') }}
    </div>
    <div class="col-lg-3" align="right">
        <ul class="nav navbar-top-links navbar-right m-t-md" align="right">
            <li>
            @if ( $lastprocedure->month_id < (int)date('m') )            
                <button class="btn btn-outline btn-primary  dim " type="button"><a href="{{ asset('payroll/addmonth' ) }}"><i class="fa fa-plus"></i> Nuevo mes </a></button>
            @else
                <button class="btn btn-outline btn-primary disabled" type="button"><i class="fa fa-plus"></i> Nuevo mes</button>
            @endif
            </li>
        </ul>
    </div>
</div>
<div class="wrapper wrapper-content animated fadeInRight">
    @if ($errors->any())
        <div class="col-lg-9">
            @foreach ($errors->all() as $error)
            <div class="alert alert-block alert-danger fade in">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <p>
                    <strong>{{ $error }}</strong>
                </p>
            </div>
            @endforeach
        </div>
    @endif
    <div class="row">
        @foreach ($procedures as $procedure)
        <div class="col-lg-4">
            <div class="contact-box center-version">
                <a href="#">
                        {{-- <img alt="image" class="img-circle" src="img/a2.jpg"> --}}
                        <h2 class="m-b-xs"><strong>{{ $procedure->month->name }}</strong></h2>
                        <div class="font-bold"><h3>{{ $procedure->year }}</h3></div>
                    </a>
                <div class="contact-box-footer">
                    <div class="m-t-xs btn-group">
                        @php ($payroll = Payroll::show_payroll_month($procedure->id))
                        @if (!$payroll)
                            <a class="btn btn-md btn-primary" href="{{ route('create_payroll', [$procedure->year, $procedure->month->name])}}" data-toggle="tooltip" data-placement="top" title="Registrar datos de la Planilla"><i class="fa fa-plus"></i> Registrar </a>
                        @else 
                            <a class="btn btn-md btn-primary" href="{{ route('edit_payroll', [$procedure->year, $procedure->month->name])}}" data-toggle="tooltip" data-placement="top" title="Editar datos de la Planilla"><i class="fa fa-pencil"></i> Editar</a>
                            <a class="btn btn-md btn-primary" href="{{ route('report_excel', [$procedure->year, $procedure->month->name])}}" data-toggle="tooltip" data-placement="top" title="Seleccionar Excel"><i class="fa fa-file-excel-o"></i></a>
                            <button class="btn btn-primary" type="button" data-toggle="tooltip" data-placement="top" title="Imprimir Boletas" onclick="printJS({printable:'{!! route('print_ticket', [$procedure->year, $procedure->month->name]) !!}', type:'pdf', showModal:true, modalMessage: 'Generando documento por favor espere un momento.'})" ><i class="fa fa-print"></i></button>
                            <a class="btn btn-md btn-primary" href="{{ route('print_txt_payroll', [$procedure->year, $procedure->month->id])}}" data-toggle="tooltip" data-placement="top" title="Descargar TXT"><i class="glyphicon glyphicon-download-alt"></i> TXT</a>
                            <a class="btn btn-md btn-primary" href="{{ route('print_ovt_payroll', [$procedure->year, $procedure->month->id, 'report_type=H', 'report_name=OVT', 'valid_contracts=0', 'consultant=0', 'with_account=0']) }}" data-toggle="tooltip" data-placement="top" title="Descargar CSV"><i class="glyphicon glyphicon-download-alt"></i> OVT</a>
                            <div class="dropdown btn-group" role="group">
                                <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">
                                    Planillas
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" style="overflow-x: hidden; max-height: 35em; height: auto;">
                                    @for ($i = 1; $i <= 2; $i++)
                                        @php ($t = ($i == 1) ? 'H' : 'P')
                                        <li><a href="#" onclick="printJS({printable:'{!! route('print_pdf_payroll', [$procedure->year, $procedure->month->id, 'report_type='.$t, 'report_name=B-'.$i, 'valid_contracts=1', 'consultant=0', 'with_account=1']) !!}', type:'pdf', showModal:true, modalMessage: 'Generando documento por favor espere un momento.'})">B-{{ $i }} ({{ $t }}.)</a></li>
                                    @endfor
                                    <li><a href="#" onclick="printJS({printable:'{!! route('print_pdf_payroll', [$procedure->year, $procedure->month->id, 'report_type=H', 'report_name=C-1', 'valid_contracts=1', 'consultant=1', 'with_account=0']) !!}', type:'pdf', showModal:true, modalMessage: 'Generando documento por favor espere un momento.'})">C-1 (CONSULTORES EN LÍNEA)</a></li>
                                    @for ($i = 1; $i <= 3; $i++)
                                        @php ($t = ($i == 1) ? 'H' : $t = ($i == 2) ? 'P' : 'T')
                                        <li><a href="#" onclick="printJS({printable:'{!! route('print_pdf_payroll', [$procedure->year, $procedure->month->id, 'report_type='.$t, 'report_name=A-'.$i, 'valid_contracts=0', 'consultant=0', 'with_account=0']) !!}', type:'pdf', showModal:true, modalMessage: 'Generando documento por favor espere un momento.'})">A-{{ $i }} ({{ $t }}.)</a></li>
                                    @endfor
                                    @php ($i = 4)
                                    @foreach (['H', 'P'] as $type)
                                        @foreach ($management_entities as $management_entity)
                                            <li><a href="#" onclick="printJS({printable:'{!! route('print_pdf_payroll', [$procedure->year, $procedure->month->id, 'report_type='.$type, 'report_name=A-'.$i, 'valid_contracts=0', 'consultant=0', 'with_account=0', 'management_entity='.$management_entity->id]) !!}', type:'pdf', showModal:true, modalMessage: 'Generando documento por favor espere un momento.'})">A-{{ $i }} ({{ $type.'. '.$management_entity->name }})</a></li>
                                            @php ($i++)
                                        @endforeach
                                    @endforeach
                                    @foreach (['H', 'P'] as $type)
                                        @foreach ($position_groups as $position_group)
                                            <li><a href="#" onclick="printJS({printable:'{!! route('print_pdf_payroll', [$procedure->year, $procedure->month->id, 'report_type='.$type, 'report_name='.$type.'-'.$i.'-'.$position_group->id, 'valid_contracts=0', 'consultant=0', 'with_account=0', 'management_entity=0', 'position_group='.$position_group->id]) !!}', type:'pdf', showModal:true, modalMessage: 'Generando documento por favor espere un momento.'})">{{ $type.'-'.$i.'-'.$position_group->id }} ({{ $position_group->name }})</a></li>
                                        @endforeach
                                        @php ($i++)
                                    @endforeach
                                </ul>
                            </div>
                        @endif
                    </div>
                </div>
            </div>
        </div>
        @endforeach
    </div>
</div>
@endsection