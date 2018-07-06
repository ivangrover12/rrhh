@extends('layouts.app') 
@section('title','Listado de contratos') 
@section('content')

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-6">
        <h2>Lista de contratos</h2>
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <a href="/">Inicio</a>
            </li>            
            <li class="breadcrumb-item active">
                <strong>contract</strong>
            </li>
        </ol>
    </div>
    <div class="col-lg-6">
        <ul class="nav navbar-top-links navbar-right m-t-md" align="right">
            <li>
                <button onclick="location.href='{{ url('contract/create') }}'" class="btn btn-outline btn-primary  dim " type="button"><i class="fa fa-share"></i> Crear contrato</button>
            </li>
            <li>
                <button onclick="location.href='{{ url('contract/checkrenovate') }}'" class="btn btn-outline btn-primary  dim " type="button"><i class="fa fa-share"></i> Renovar contratos</button>
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
                        <table id="contract-table" class="table table-striped table-bordered" id="contract-table" style="width:100%">
                            <thead>
                                <tr>
                                    <th>CI</th>
                                    <th>Funcionario</th>
                                    <th>Cargo</th>
                                    <th>Puesto</th>
                                    <th>Fecha Inicio</th>
                                    <th width="70">Fecha de Conclusion</th>
                                    <th>Tipo</th>
                                    <th style="text-align: center;">
                                        <span id="label-status">Vigentes</span>
                                        <input type="checkbox" name="" id="status" checked="true" style="transform: scale(1.5);">
                                    </th>
                                    <th width="300">Acci&oacute;n</th>
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
        var table = $('#contract-table').DataTable({
            "ajax":"contract/list/"+$("#status").val(),
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
        $("#status").change(function() {
            if ($("#status").is(':checked')) {
                table.ajax.url( 'contract/list/true' ).load();
                $("#label-status").text("Vigentes");
            }
            else {
                table.ajax.url( 'contract/list/false' ).load();
                $("#label-status").text("Concluidos");
            }            
        });
    });
</script>
@endsection