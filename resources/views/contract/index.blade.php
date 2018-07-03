@extends('layouts.app') 
@section('title','Listado de contratos') 
@section('content')

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-9">
        ruta
    </div>
</div>

<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-lg-12">            
            <a class="btn btn-primary" type="button" href="{{ asset('contract/create' ) }}"><i class="fa fa-check-circle"></i>&nbsp;Crear contrato</a>
            <div class="table-responsive">
                <table id="contract-table" class="table table-striped table-bordered" id="contract-table" style="width:100%">
                    <thead>
                        <tr>
                            {{-- <th>id</th> --}}
                            <th>CI</th>
                            <th>Apellido</th>
                            <th>Apellido materno</th>
                            <th>Nombre</th>
                            <th>Segundo Nombre</th>
                            <th>Cargo</th>
                            <th>Puesto</th>
                            <th>Fecha de contrato Inicio</th>
                            <th>Fecha de contrato Fin</th>
                            <th>Estado</th>
                            <th>Acci&oacute;n</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($contracts as $contract)
                            <tr>
                                {{-- <td> {{ $contract->id }} </td> --}}
                                <td> {{ $contract->employee->identity_card }} </td>
                                <td> {{ $contract->employee->last_name }} </td>
                                <td> {{ $contract->employee->mothers_last_name }} </td>
                                <td> {{ $contract->employee->first_name }} </td>
                                <td> {{ $contract->employee->second_name }} </td>
                                <td> {{ $contract->position->name }} </td>
                                <td> {{ $contract->position->position_group->name }} </td>
                                <td> {{ date("d-m-Y", strtotime($contract->date_start)) }} </td>
                                <td> {{ date("d-m-Y", strtotime($contract->date_end)) }} </td>
                                <td>
                                    @if ($contract->status)
                                        <i class="fa fa-check"></i>
                                    @else
                                        <i class="fa fa-times"></i>
                                    @endif

                                </td>
                                <td> 
                                    <a class="btn btn-primary" type="button" href="{{ asset('contract/'.$contract->id ) }}"><i class="fa fa-eye"></i>&nbsp;Ver</a>
                                    <a class="btn btn-default" type="button" href="{{ asset('contract/'.$contract->id.'/edit' ) }}"><i class="fa fa-pencil"></i>&nbsp;Editar</a>
                                    @if ($contract->employee->employee_type_id != 3)
                                        <button class="btn btn-primary" type="button" data-toggle="tooltip" data-placement="top" title="Afiliacion y reingreso del trabajador" onclick="printJS({printable:'{!! route('print_high_insurance', [$contract->id]) !!}', type:'pdf', showModal:true, modalMessage: 'Generando documento por favor espere un momento.'})" ><i class="fa fa-print"></i></button>
                                        <button class="btn btn-primary" type="button" data-toggle="tooltip" data-placement="top" title="Aviso de baja del asegurado" onclick="printJS({printable:'{!! route('print_low_insurance', [$contract->id]) !!}', type:'pdf', showModal:true, modalMessage: 'Generando documento por favor espere un momento.'})" ><i class="fa fa-print"></i></button>
                                    @endif
                                    
                                </td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
@endsection
@section('jss')
<script>
    $(document).ready(function(){
        $('#contract-table').DataTable({
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
    });
</script>
@endsection