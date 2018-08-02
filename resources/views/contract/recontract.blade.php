@extends('layouts.app') 
@section('title','Renovar contrato') 
@section('content')

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <h2>Renovar contrato</h2>
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <a href="/">Inicio</a>
            </li>
            <li class="breadcrumb-item">
                <a href="/contract">contratos</a>
            </li>            
            <li class="breadcrumb-item active">
                <strong>renovar contrato</strong>
            </li>
        </ol>
    </div>
    <div class="col-lg-2" align="right">
        <ul class="breadcrumb m-t-md">
            <li><button onclick="location.href='{{ url('contract') }}'" class="btn btn-outline btn-primary dim" type="button"><i class="fa fa-reply"></i> volver </button></li>
        </ul>
        
    </div>
</div>

<div class="wrapper wrapper-content fadeInRight">
    <div class="row">
        <div class="ibox ">
            <div class="ibox-title">
                
            </div>
            <div class="ibox-content">
                <div class="row">

                    <div class="col-lg-6">
                        <form method="POST" action="{{asset('contract/save_recontract')}}">
                            {{ csrf_field() }}
                            <input type="hidden" name="id" value="{{ $contract->id }} ">
                            <div class="form-group row">
                                <div class="col-md-4">Empleado</div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control" disabled value="{{$employee->fullName()}}">
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">C.I. </div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control" disabled value="{{$employee->identity_card}}"  >
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">Cargo: </div>
                                <div class="col-md-8">
                                    <input type="hidden" name="position_id" id="position_id" class="form-control" value=" {{ $contract->position_id }} "/>
                                    <input type="text" id="position" placeholder="Cargo" class="form-control" value=" {{ $contract->position->name }} " disabled/>
                                    <div class="text-danger">{{ $errors->first('position_id') }}</div>                               
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4"> Tipo de contratación </div>
                                <div class="col-md-8">
                                    <select name="contract_type" class="form-control" disabled>
                                        @foreach ($contract_type as $type)
                                            @if (3 == $type->id) 
                                                <option value="{{ $type->id }} " selected="true">{{ $type->name }} </option>
                                            @endif                                            
                                        @endforeach
                                    </select>
                                </div> 
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">Fecha de inicio <span class="text-danger">*</span></div>
                                <div class="col-md-8">
                                    <input type="date" id="date_start" name="date_start" min="{{ $contract->date_end }}" class="form-control" onchange="calc()">
                                    <div class="text-danger">{{ $errors->first('date_start') }}</div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">Fecha de Conclusión </div>
                                <div class="col-md-8">
                                    <input type="date" id="date_end" name="date_end" min="{{ $contract->date_end }}" class="form-control" onchange="calc()">
                                    <div class="text-danger">{{ $errors->first('date_end') }}</div>
                                </div>
                            </div>
                                                    
                            <div class="form-group row">
                                <div class="col-md-4"> Numero de contrato </div>
                                <div class="col-md-8">
                                    <input type="text" name="number_contract" id="number_contract" class="form-control" placeholder="Ej.: 999/2018" />
                                    <div class="text-danger">{{ $errors->first('number_contract') }}</div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">Numero de asegurado </div>
                                <div class="col-md-8">
                                    <input type="text" name="number_insurance" value="{{ $contract->number_insurance }}" class="form-control">
                                </div>
                            </div>                                                 
                            <div class="form-group row">
                                <div class="col-md-4">Cite de Resursos Humanos </div>
                                <div class="col-md-8">
                                    <input type="text" name="cite_rrhh" class="form-control" placeholder="Ej.: RR.HH.-120/2018" />
                                    <div class="text-danger">{{ $errors->first('cite_rrhh') }}</div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">Fecha del cite </div>
                                <div class="col-md-8">
                                    <input type="date" name="cite_rrhh_date" min="{{ $contract->date_end }}" class="form-control">
                                    <div class="text-danger">{{ $errors->first('cite_rrhh_date') }}</div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4"> Cite de desempeño</div>
                                <div class="col-md-8">
                                    <input type="text" name="cite_performance" value="{{ $contract->cite_performance }}" class="form-control">
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
                                                    <label><input type="radio" name="schedule" value="1|2" checked >
                                                    Horario  (08:00-12:00 | 14:30-18:30)</label><br>
                                                @else
                                                    <label><input type="radio" name="schedule" value=" {{ $schedule->id }} " checked >
                                                    Horario  ({{str_pad($schedule->start_hour,2,0,STR_PAD_LEFT).':'.str_pad($schedule->start_minutes,2,0,STR_PAD_LEFT)}}-
                                                    {{str_pad($schedule->end_hour,2,0,STR_PAD_LEFT).':'.str_pad($schedule->end_minutes,2,0,STR_PAD_LEFT)}})</label><br>
                                                @endif
                                            @else
                                                @if ($schedule->id == 1 )
                                                    <label><input type="radio" name="schedule" value="1|2" >
                                                    Horario  (08:00-12:00 | 14:30-18:30)</label><br>
                                                @elseif ($schedule->id == 2)

                                                @else
                                                    <label><input type="radio" name="schedule" value=" {{ $schedule->id }} " >
                                                    Horario  ({{str_pad($schedule->start_hour,2,0,STR_PAD_LEFT).':'.str_pad($schedule->start_minutes,2,0,STR_PAD_LEFT)}}-
                                                    {{str_pad($schedule->end_hour,2,0,STR_PAD_LEFT).':'.str_pad($schedule->end_minutes,2,0,STR_PAD_LEFT)}})</label><br>
                                                @endif                                                
                                            @endif
                                        @else
                                            @if ($schedule->id == 1 )
                                                <label><input type="radio" name="schedule" value="1|2" >
                                                Horario  (08:00-12:00 | 14:30-18:30)</label><br>
                                            @elseif ($schedule->id == 2)

                                            @else
                                                <label><input type="radio" name="schedule" value=" {{ $schedule->id }} " >
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
                                    Descripción del contrato
                                </div>
                                <div class="col-md-8">
                                    <textarea name="description" class="form-control">{{ $contract->description }} </textarea>
                                </div>
                            </div>
                            <div class="col-md-12" align="right">
                                <button type="submit" class="btn btn-primary">Guardar</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6">
                        <div class="alert alert-info">
                            <span class="alert-link">Empleado: </span><span id="emp"> {{$employee->fullName()}}</span><br>
                            <span class="alert-link">Cargo: </span><span id="pos"> {{ $contract->position->name }}</span><br>
                            <span class="alert-link">Haber Basico: </span> Bs. <span id="sal">{{ $contract->position->charge->base_wage }} </span><br>
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
    $('#position').typeahead({
        source: <?= $position ?>,
        displayText: function(item) {
            return item.name
        },
        afterSelect: function(item) {
            $('#position_id').val(item.id);
            $("#pos").text(item.name);
            $("#sal").text(item.base_wage);
            calc();
        }
    });
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