@extends('layouts.app') 
@section('title','Editar contrato') 
@section('content')

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <h2>Ver contrato</h2>
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <a href="/">Inicio</a>
            </li>
            <li class="breadcrumb-item">
                <a href="/contract">contratos</a>
            </li>            
            <li class="breadcrumb-item active">
                <strong>ver contrato</strong>
            </li>
        </ol>
    </div>
    <div class="col-lg-2" align="right">
        <ul class="breadcrumb m-t-md">
            <li><a href="/contract"><button class="btn btn-outline btn-primary dim" type="button"><i class="fa fa-reply"></i> volver </button></a></li>
        </ul>
        
    </div>
</div>

<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="ibox ">
            <div class="ibox-title">
                
            </div>
            <div class="ibox-content">
                <div class="row">
                    <div class="col-md-4">&nbsp;</div>
                    <div class="col-lg-4">
                            @if ($errors->any())
                            <div class="alert alert-danger">
                                <h2>Se encontraron los siguientes errores. ({{ count($errors->all()) }})</h2>
                                <ol>
                                    @foreach ($errors->all() as $error)
                                    <li>{{ $error }}</li>
                                    @endforeach
                                </ol>
                            </div>
                            @endif
                        
                            <input name="_method" type="hidden" value="PATCH">
                            <div class="form-group row">
                                <div class="col-md-4">Empleado</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control" disabled value="{{$contract->employee->fullName()}}" disabled>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">C.I. </div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control" disabled value="{{$contract->employee->identity_card}}" disabled>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">Cargo:</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control" disabled value="{{$contract->position->name}}" disabled>
                                    <input type="hidden" id="position_id" name="position_id" value="{{ $contract->position_id }} ">
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">Fecha de inicio</div>
                                <div class="col-md-8">
                                    <input type="date" id="date_start" name="date_start" value="{{ $contract->date_start }}" class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">Fecha de fin</div>
                                <div class="col-md-8">
                                    <input type="date" id="date_end" name="date_end" value="{{ $contract->date_end }}" class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">Tipo de contratacion</div>
                                <div class="col-md-8">
                                    <input type="text" id="date_end" name="date_end" value="{{ $contract->contracttype->name }}" class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4"> Numero de Contrato </div>
                                <div class="col-md-8">
                                    <input type="text" name="number_contract" value="{{ $contract->number_contract }}" class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">Numero de asegurado </div>
                                <div class="col-md-8">
                                    <input type="text" name="number_insurance" value="{{ $contract->number_insurance }}" class="form-control" disabled>
                                </div>
                            </div>
                            
                            <div class="form-group row">
                                <div class="col-md-4">Cite de Resursos Humanos </div>
                                <div class="col-md-4">
                                    <input type="text" name="cite_rrhh" value="{{ $contract->cite_rrhh }}" class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">Fecha del cite </div>
                                <div class="col-md-8">
                                    <input type="date" name="cite_rrhh_date" value="{{ $contract->cite_rrhh_date }}" class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">Referencia de convocatoria </div>
                                <div class="col-md-8">
                                    <input type="text" name="numer_announcement" value="{{ $contract->numer_announcement }}" class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4"> Cite de desempeño</div>
                                <div class="col-md-8">
                                    <input type="text" name="cite_performance" value="{{ $contract->cite_performance }}" class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4"> Horarios 
                                </div>
                                <div class="col-md-8">
                                    @foreach ( $schedules as $schedule)
                                        @if (isset($contract->schedules[0]->id))
                                            @if($schedule->id == $contract->schedules[0]->id)
                                                @if (isset($contract->schedules[1]->id))
                                                    <label><input type="radio" name="schedule" value="1|2" checked disabled>
                                                    Horario  (08:00-12:00 | 14:30-18:30)</label><br>
                                                @else
                                                    <label><input type="radio" name="schedule" value=" {{ $schedule->id }} " checked  disabled>
                                                    Horario  ({{str_pad($schedule->start_hour,2,0,STR_PAD_LEFT).':'.str_pad($schedule->start_minutes,2,0,STR_PAD_LEFT)}}-
                                                    {{str_pad($schedule->end_hour,2,0,STR_PAD_LEFT).':'.str_pad($schedule->end_minutes,2,0,STR_PAD_LEFT)}})</label><br>
                                                @endif
                                            @else
                                                @if ($schedule->id == 1 )
                                                    <label><input type="radio" name="schedule" value="1|2" disabled>
                                                    Horario  (08:00-12:00 | 14:30-18:30)</label><br>
                                                @elseif ($schedule->id == 2)

                                                @else
                                                    <label><input type="radio" name="schedule" value=" {{ $schedule->id }} " disabled>
                                                    Horario  ({{str_pad($schedule->start_hour,2,0,STR_PAD_LEFT).':'.str_pad($schedule->start_minutes,2,0,STR_PAD_LEFT)}}-
                                                    {{str_pad($schedule->end_hour,2,0,STR_PAD_LEFT).':'.str_pad($schedule->end_minutes,2,0,STR_PAD_LEFT)}})</label><br>
                                                @endif                                                
                                            @endif
                                        @else
                                            @if ($schedule->id == 1 )
                                                <label><input type="radio" name="schedule" value="1|2" disabled>
                                                Horario  (08:00-12:00 | 14:30-18:30)</label><br>
                                            @elseif ($schedule->id == 2)

                                            @else
                                                <label><input type="radio" name="schedule" value=" {{ $schedule->id }} " disabled>
                                                Horario  ({{str_pad($schedule->start_hour,2,0,STR_PAD_LEFT).':'.str_pad($schedule->start_minutes,2,0,STR_PAD_LEFT)}}-
                                                {{str_pad($schedule->end_hour,2,0,STR_PAD_LEFT).':'.str_pad($schedule->end_minutes,2,0,STR_PAD_LEFT)}})</label><br>
                                            @endif 
                                        @endif
                                    @endforeach
                                    <div class="text-danger"> {{ $errors->first('schedule') }}</div>
                                                                     
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">
                                    Descripción
                                </div>
                                <div class="col-md-8">
                                    <textarea name="description" class="form-control" disabled>{{ $contract->description }} </textarea>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">Contrato Vigente:</div>
                                <div class="col-md-8">
                                    @if ($contract->status)
                                        <input style="transform: scale(1.5);"  type="checkbox" checked name="status" disabled>
                                    @else
                                        <input style="transform: scale(1.5);"  type="checkbox" name="status" disabled>
                                    @endif
                                </div>
                            </div>
                            <div class="col-md-12" align="right">
                                
                            </div>
                    </div>
                    <div class="col-md-3">
                        <div class="alert alert-info">
                            <span class="alert-link">Empleado: </span><span id="emp"> {{$contract->employee->fullName()}}</span><br>
                            <span class="alert-link">Cargo: </span><span id="pos"> {{ $contract->position->name }} [Bs. {{ $contract->position->charge->base_wage }} ] </span><br>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Mes</th>
                                        <th>Dias trabajados</th>
                                        <th>Salario</th>
                                    </tr>
                                </thead>
                                <tbody id="table_calc"></tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="2"><span class="alert-link">Total </span></td>
                                        <td id="total_ganado">*</td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
@section('jss')
<script type="text/javascript">
    function calc() {
        $.get( "/contract/month_salary_calculation", { date_ini: $("#date_start").val(), 
                                                        date_end: $("#date_end").val(),
                                                        position_id: $("#position_id").val() } )
            .done(function( data ) {
                $("#table_calc").empty();
                total = 0;
                for(var dato of data){     
                    salary = (Math.round( parseFloat(dato.salary) * 100 )/100 ).toFixed(2);               
                    $("#table_calc").append('<tr><td>' + dato.month + '</td><td>' + dato.day + '</td><td>Bs. ' + salary + '</td></tr>');
                    total = total + parseFloat(salary);                    
                }
                total = (Math.round( total * 100 ) / 100 ).toFixed(2);
                $("#total_ganado").text('Bs. ' + total);
            });
    }
    calc();
</script>
@endsection