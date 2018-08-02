@extends('layouts.app') 
@section('title','Listado de contratos') 
@section('styles')
<link rel="stylesheet" type="text/css" href="{{ asset('css/swich.css') }} ">
@endsection
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
            <!--<li>
                <button onclick="location.href='{{ url('contract/checkrenovate') }}'" class="btn btn-outline btn-primary  dim " type="button"><i class="fa fa-share"></i> Renovar contratos</button>
            </li>-->
        </ul>
    </div>
</div>

<div class="wrapper wrapper-content fadeInRight">
    <div class="row">
        <div class="col-lg-12">
            @include('layouts.flash-message')
            <div class="ibox ">
                <div class="ibox-title" style="height: 80px">
                    <div class="col-md-10">
                        <div class="col-lg-12"><span class="badge badge-warning">&nbsp;&nbsp;</span> El contrato vence hoy</div>
                        <div class="col-lg-12"><span class="badge badge-danger">&nbsp;&nbsp;</span> El contrato ya vencio</div>
                        
                    </div>
                    <div class="col-md-2">
                        
                        <div class="col-lg-6" align="right">
                            <strong>Ver Contratos</strong>
                        </div>
                        <div class="col-lg-6">
                            <div class="onoffswitch2">
                                <input type="checkbox" name="onoffswitch2" class="onoffswitch-checkbox2" id="status" checked>
                                <label class="onoffswitch-label2" for="status">
                                    <span class="onoffswitch-inner2"></span>
                                    <span class="onoffswitch-switch2"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                            
                </div>
                <div class="ibox-content">
                    <div class="table-responsive">
                        <table id="contract-table" class="table table-bordered display responsive nowrap" style="width:100%">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Opciones</th>
                                    <th>C.I.</th>
                                    <th>Funcionario</th>
                                    <th>Cargo</th>
                                    <th>Puesto</th>
                                    <th>Area</th>
                                    <th>Tipo de Contrato</th>
                                    <td>Numero Contrato</td>
                                    <th>Fecha Inicio</th>
                                    <th>Fecha Conclusion</th>
                                    <th>Fecha Retiro/Disolucion</th>
                                    <th>Motivo Retiro/Disolucion</th>
                                    <th>Numero de Asegurado</th>
                                    <th>Cite RRHH</th>
                                    <th>Fecha de Cite RRHH</th>
                                    <th>Referencia de Convocatoria</th>
                                    <th>Cite de Desempeño</th>
                                    <th>Descripcion</th>
                                    <th>Estado</th>
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
            responsive: true,
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
            },
            "createdRow": function( row, data, dataIndex){
                fdata = data[10].split("-");                
                fdata = new Date(fdata[1]+'-'+fdata[0]+'-'+fdata[2]);
                fhoy = new Date();

                
                if( fdata.setHours(0,0,0,0) ==  fhoy.setHours(0,0,0,0)){
                    $(row).addClass('bg bg-warning');
                }
                if( fdata.setHours(0,0,0,0) <  fhoy.setHours(0,0,0,0)){
                    if (data[19] == 'Concluido') {
                        $(row).addClass('bg bg-muted');
                        $(row).find("[class*='delete']").hide();
                        $(row).find("[class*='recontract']").hide();
                    } else {
                        $(row).addClass('bg bg-danger');    
                    }                    
                }
            },
            "initComplete": function () {
                var api = this.api();
                api.$('td .delete').click( function () {
                    var id = $(this).attr("data");
                    swal({
                        title: "Esta seguro de eliminar permanentemente este contrato?",
                        text: "",
                        type: "warning",
                        showCancelButton: true,
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "Si",
                        cancelButtonText: "Cancelar",
                        closeOnConfirm: false
                    }, function () {
                        location.assign("/contract/delete/" + id);
                    });

                });
                $('[data-toggle="tooltip"]').tooltip();
                
            },
            stateSave: true            
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