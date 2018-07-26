@extends('layouts.app') 
@section('title','Crear contrato') 
@section('content')

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <h2>Crear contrato</h2>
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <a href="/">Inicio</a>
            </li>
            <li class="breadcrumb-item">
                <a href="/contract">contratos</a>
            </li>            
            <li class="breadcrumb-item active">
                <strong>crear contrato</strong>
            </li>
        </ol>
    </div>
    <div class="col-lg-2" align="right">
        <ul class="breadcrumb m-t-md">
            <li><button onclick="location.href='{{ url('contract') }}'" class="btn btn-outline btn-primary dim" type="button"><i class="fa fa-reply"></i> volver </button></li>
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
                        <form method="POST" action="{{asset('contract')}}">
                            {{ csrf_field() }}
                            <div class="form-group row">
                                <div class="col-md-4"> Empleado <span class="text-danger">*</span></div>
                                <div class="col-md-8">
                                    <input type="hidden" name="employee_id" id="employee_id" class="form-control" />
                                    <input type="text" id="employee" placeholder="C.I. , Nombres, Apellidos" class="form-control" />
                                    <div class="text-danger">{{ $errors->first('employee_id') }}</div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4"> Cargo <span class="text-danger">*</span></div>
                                <div class="col-md-8">
                                    <input type="hidden" name="position_id" id="position_id" class="form-control"/>
                                    <input type="text" id="position" placeholder="Cargo" class="form-control" />
                                    <div class="text-danger">{{ $errors->first('position_id') }}</div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4"> Fecha de Inicio <span class="text-danger">*</span></div>
                                <div class="col-md-8">
                                    <input type="date" id="date_start" name="date_start" class="form-control" onchange="calc()">
                                    <div class="text-danger">{{ $errors->first('date_start') }}</div>
                                </div>                                
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4"> Fecha de Conclusión/Disolución <span class="text-danger">*</span></div>
                                <div class="col-md-8">
                                    <input type="date" id="date_end" name="date_end" class="form-control" onchange="calc()">
                                    <div class="text-danger">{{ $errors->first('date_end') }}</div>
                                </div>                                
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4"> Tipo de contratación <span class="text-danger">*</span></div>
                                <div class="col-md-8">
                                    <select name="contract_type" class="form-control">
                                        @foreach ($contract_type as $type)
                                            <option value="{{ $type->id }} ">{{ $type->name }} </option>
                                        @endforeach
                                    </select>
                                </div> 
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4"> Numero de contrato </div>
                                <div class="col-md-8">
                                    <input type="text" name="number_contract" id="number_contract" class="form-control" placeholder="mXXX/2018" />
                                    <div class="text-danger">{{ $errors->first('number_contract') }}</div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4"> 
                                    Numero de asegurado 
                                </div>
                                <div class="col-md-8">
                                    <input type="text" name="number_insurance" class="form-control" placeholder="11-1111-XXX">
                                </div>
                            </div>                            
                            <div class="form-group row">
                                <div class="col-md-4">
                                    Cite de Resursos Humanos 
                                </div>
                                <div class="col-md-8">
                                    <input type="text" name="cite_rrhh" class="form-control" placeholder="RR.HH.-120/2018">
                                    <div class="text-danger">{{ $errors->first('cite_rrhh') }}</div>
                                </div>                                
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">  Fecha del cite </div>
                                <div class="col-md-8">
                                    <input type="date" name="cite_rrhh_date" class="form-control">
                                    <div class="text-danger">{{ $errors->first('cite_rrhh_date') }}</div>
                                </div>         
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">
                                    Referencia de convocatoria 
                                </div>
                                <div class="col-md-8">
                                    <input type="text" name="numer_announcement" class="form-control" placeholder="URH-028">
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4"> Cite de desempeño</div>
                                <div class="col-md-8">
                                    <input type="text" name="cite_performance" class="form-control">
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4"> Horarios 
                                </div>
                                <div class="col-md-8">
                                    @foreach ( $schedules as $schedule)                                        
                                        @if ($schedule->id == 1 )
                                            <label><input type="radio" name="schedule" value="1|2" checked>
                                            Horario  (08:00-12:00 | 14:30-18:30)</label><br>
                                        @elseif ($schedule->id == 2)

                                        @else
                                            <label><input type="radio" name="schedule" value=" {{ $schedule->id }} " >
                                            Horario  ({{str_pad($schedule->start_hour,2,0,STR_PAD_LEFT).':'.str_pad($schedule->start_minutes,2,0,STR_PAD_LEFT)}}-
                                            {{str_pad($schedule->end_hour,2,0,STR_PAD_LEFT).':'.str_pad($schedule->end_minutes,2,0,STR_PAD_LEFT)}})</label><br>
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
                                    <textarea name="description" class="form-control"> </textarea>
                                </div>
                            </div>
                            <div class="col-md-12" align="right">
                                <button type="submit" class="btn btn-primary" >Guardar</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-3">
                        <div class="alert alert-info">
                            <span class="alert-link">Empleado: </span><span id="emp"> *</span><br>
                            <span class="alert-link">Cargo: </span><span id="pos"> *</span><br>
                            <span class="alert-link">Haber Basico: </span> Bs. <span id="sal"> *</span><br>
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
    $('#employee').typeahead({
        source: <?= $employees ?>,
        displayText: function(item) {
            return item.identity_card + ' ' + item.first_name + ' ' + (item.second_name? item.second_name : "") + ' ' + (item.last_name? item.last_name : "") + ' ' + (item.mothers_last_name? item.mothers_last_name : "")
        },
        afterSelect: function(item) {
            $('#employee_id').val(item.id);
            $('#emp').text(item.first_name + ' ' + (item.second_name? item.second_name : "") + ' ' + (item.last_name? item.last_name : "") + ' ' + (item.mothers_last_name? item.mothers_last_name : ""));
        }
    });
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
</script>
@endsection