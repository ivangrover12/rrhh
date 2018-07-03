@extends('layouts.app') 
@section('title','Crear empleado') 
@section('content')

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-9">
        ruta
    </div>
</div>


<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-lg-12">
            <a class="btn btn-primary" type="button" href="{{ asset('employee/create' ) }}"><i class="fa fa-check-circle"></i>&nbsp;Crear Empleado</a>
            <table id="employee-table" class="table table-striped table-bordered myTable" style="width:100%">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>CI</th>
                        <th>Apellido</th>
                        <th>Materno</th>
                        <th>Name</th>
                        <th>Segundo Nombre</th>
                        <th>Fecha de nacimiento</th>
                        <th>Nro Cuenta</th>
                        <th>CUA/NUA</th>
                        <th>AFP</th>         
                        <th>Tipo</th>
                        <th>Acci&oacute;n</th>
                    </tr>
                </thead>
                <tbody>
                    
                </tbody>
            </table>
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
            }
        });
    });    
</script>
@endsection