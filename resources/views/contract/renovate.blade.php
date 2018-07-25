@extends('layouts.app') 
@section('title','Renovar contratos') 
@section('content')
<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <h2>Renovar contratos</h2>
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <a href="/">Inicio</a>
            </li>
            <li class="breadcrumb-item">
                <a href="/contract">contratos</a>
            </li>            
            <li class="breadcrumb-item active">
                <strong>check contract</strong>
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
                    <form method="POST" action="{{asset('contract/renovate')}}">
                    {{ csrf_field() }}
                    <div class="col-md-8">
                        <div class="bg-info p-xs b-r-sm"> Contratos vigentes con fecha de conclusion del <strong>{{ $fecha1 }}</strong> al <strong>{{ $fecha2 }}</strong></div><br>
                        <div class="table-responsive col-md-12">

                            <table id="table-contract-renovate" class="table table-striped table-bordered" id="contract-table" style="width:100%">
                                
                                <thead>
                                    <tr>
                                        <th>CI</th>
                                        <th>Funcionario</th>
                                        <th>Cargo</th>
                                        <th>Puesto</th>
                                        <th>Fecha Inicio</th>
                                        <th>Fecha Conclusion</th>
                                        <th>Renovar? <br>
                                            <div class="checkbox checkbox-primary">
                                                <input type="checkbox" name="" id="checkTodos" checked="true" align="center">
                                                <label for="checkTodos"></label>
                                            </div>
                                            <div class="text-danger">{{ $errors->first('renovar') }}</div>
                                        </th>
                                        <!--<th>Cite RRHH</th>
                                        <th>Cite Evaluacion Desempeño</th>-->
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($contracts as $contract)
                                        <tr>
                                            <td> {{ $contract->employee->identity_card }} </td>
                                            <td> {{ Util::fullName($contract->employee) }} </td>
                                            <td> {{ $contract->position->name }} </td>
                                            <td> {{ $contract->position->position_group->name }} </td>
                                            <td> {{ date("d-m-Y", strtotime($contract->date_start)) }} </td>
                                            <td> {{ date("d-m-Y", strtotime($contract->date_end)) }} </td>
                                            <td>
                                                <div class="checkbox checkbox-success">
                                                    <input type="checkbox" name="renovar[]" id="renovar" value=" {{ $contract->id }} " checked="true">
                                                    <label for="renovar"></label>
                                                </div>
                                            </td>                                    
                                            <!--<td width="100">
                                                <input type="text" name="{{ $contract->id }}_cite_rrhh" id="cite_rrhh" placeholder="CITE RRHH" class="form-control">
                                                <input type="date" name="{{ $contract->id }}_date_cite_rrhh" id="date_cite_rrhh" class="form-control">
                                            </td>
                                            <td width="110">
                                                <input type="text" name="{{ $contract->id }}_cite_performance" id="cite_performance" placeholder="CITE de Evaluación" class="form-control">                                                
                                            </td>-->
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group row"><label class="col-lg-4 col-form-label">Fecha de inicio <span class="text-danger">*</span></label>
                            <div class="col-lg-8">
                                <input type="date" name="date_start" class="form-control">
                                <div class="text-danger">{{ $errors->first('date_start') }}</div>
                            </div>
                        </div>
                        <div class="form-group row"><label class="col-lg-4 col-form-label">Fecha de conclusion <span class="text-danger">*</span></label>
                            <div class="col-lg-8">
                                <input type="date" name="date_end" class="form-control">
                                <div class="text-danger">{{ $errors->first('date_end') }}</div>
                            </div>
                        </div>
                        <div class="col-md-12" align="right">
                            <button class="btn btn-sm btn-primary float-right m-t-n-xs" type="submit"><strong>Registrar</strong></button>
                        </div>
                    </div>
                </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
@section('jss')
<script>
    $(document).ready(function(){
        $('#table-contract-renovate').DataTable({
            "pageLength": 1000,
            "lengthChange": false,
            "language": {
                "sProcessing":     "Procesando...",
                "sLengthMenu":     "Mostrar _MENU_ registros",
                "sZeroRecords":    "No se encontraron resultados",
                "sEmptyTable":     "Ningún dato disponible en esta tabla",
                "sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                "sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
                "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
                "sInfoPostFix":    "",
                "sSearch":         "Buscar:",
                "sUrl":            "",
                "sInfoThousands":  ",",
                "sLoadingRecords": "Cargando...",
                "oPaginate": {
                    "sFirst":    "Primero",
                    "sLast":     "Último",
                    "sNext":     "Siguiente",
                    "sPrevious": "Anterior"
                },
                "oAria": {
                    "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
                    "sSortDescending": ": Activar para ordenar la columna de manera descendente"
                }
            }
        });
        $("#checkTodos").change(function () {
              $("input:checkbox").prop('checked', $(this).prop("checked"));
          });
    });
</script>
@endsection