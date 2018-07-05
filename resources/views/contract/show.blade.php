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
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">Fecha de inicio</div>
                                <div class="col-md-8">
                                    <input type="date" name="date_start" value="{{ $contract->date_start }}" class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">Fecha de fin</div>
                                <div class="col-md-8">
                                    <input type="date" name="date_end" value="{{ $contract->date_end }}" class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4">Numero de asegurado </div>
                                <div class="col-md-8">
                                    <input type="text" name="number_insurance" value="{{ $contract->number_insurance }}" class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-4"> Numero de Contrato </div>
                                <div class="col-md-8">
                                    <input type="text" name="number_contract" value="{{ $contract->number_contract }}" class="form-control" disabled>
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
                                <div class="col-md-4">Numero de convocatoria </div>
                                <div class="col-md-8">
                                    <input type="text" name="numer_announcement" value="{{ $contract->numer_announcement }}" class="form-control" disabled>
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
                </div>
            </div>
        </div>
    </div>
</div>
@endsection