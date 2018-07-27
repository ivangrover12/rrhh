@extends('layouts.app') 
@section('title','Empleados')
@section('content')

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-6">
        <h2>Lista de Empleados</h2>
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <a href="/">Inicio</a>
            </li>            
            <li class="breadcrumb-item active">
                <strong>empleados</strong>
            </li>
        </ol>
    </div>
    <div class="col-lg-6">
        <ul class="nav navbar-top-links navbar-right m-t-md" align="right">
            <li>
                <button onclick="location.href='{{ url('employee/create') }}'" class="btn btn-outline btn-primary  dim " type="button"><i class="fa fa-share"></i> Crear empleado</button>
            </li>
        </ul>
    </div>
</div>
<div class="wrapper wrapper-content fadeInRight">
    <div class="row">
        <div class="col-lg-12">
            @include('layouts.flash-message')
            <div class="ibox ">
                <div class="ibox-title">
                    
                </div>
                <div class="ibox-content">
                    <div class="table-responsive">
                        <table id="employee-table" class="table table-striped table-bordered myTable" style="width:100%">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th class="abc">CI</th>
                                    <th>Apellido</th>
                                    <th>Materno</th>
                                    <th>Name</th>
                                    <th>Segundo Nombre</th>
                                    <th>Fecha de nacimiento</th>
                                    <th>Nro Cuenta</th>
                                    <th>CUA/NUA</th>
                                    <th>AFP</th>         
                                    <th>Tipo</th>
                                    <th>Activo</th>
                                    <th>Acci&oacute;n</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


@endsection

@section('jss')

<script>
    $(document).ready(function(){

        $('.myTable').DataTable({            
            "ajax":"employee/list",
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
            },
            "initComplete": function(settings, json) {
                var api = this.api();
                api.$('td .status').click( function () {
                    $.get("employee/status/" + $(this).val());
                });
            },
            stateSave: true
        });


    });    
</script>

@endsection
