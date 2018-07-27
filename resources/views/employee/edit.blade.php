@extends('layouts.app') 
@section('title','Editar empleado') 
@section('content')

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <h2>Editar Empleado</h2>
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <a href="/">Inicio</a>
            </li>
            <li class="breadcrumb-item">
                <a href="/employee">empleados</a>
            </li>            
            <li class="breadcrumb-item active">
                <strong>editar empleado</strong>
            </li>
        </ol>
    </div>
    <div class="col-lg-2" align="right">
        <ul class="breadcrumb m-t-md">
            <li><a href="/employee"><button class="btn btn-outline btn-primary dim" type="button"><i class="fa fa-reply"></i> volver </button></a></li>
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
                    <form method="POST" action="{{asset('employee/'.$employee->id)}}">
                        <div class="col-md-3">&nbsp;</div>
                        <div class="col-md-6">
                            <input name="_method" type="hidden" value="PUT">
                                {{ csrf_field() }} 
                            Tipo de empelado
                            <select id="" name="employee_type_id" class="form-control">
                                <option></option>
                                @foreach($employee_types as $employee_type)            
                                    <option value="{{$employee_type->id}}" @if($employee_type->id == $employee->employee_type_id) selected @endif>{{$employee_type->name}}</option>
                                @endforeach
                            </select>
                        </div>
                        <br>
                        <div class="col-md-6">
                            <fieldset>
                                <legend>Datos personales</legend>
                            

                                Cedula de Identidad: <span class="text-danger">*</span>
                                <input type="text" name="identity_card" value="{{$employee->identity_card}}" class="form-control">
                                <div class="text-danger">{{ $errors->first('identity_card') }}</div>
                                <br>
                                Expedici&oacute;n
                                <select id="" class="form-control" name="city_identity_card_id">
                                <option></option>
                                @foreach($cities as $city)
                                    <option value="{{$city->id}}" @if($employee->city_identity_card_id == $city->id) selected @endif >{{$city->name}}</option>
                                @endforeach
                                </select>
                                <br>
                                Primer Nombre <span class="text-danger">*</span>
                                <input type="text" name="first_name" value="{{$employee->first_name}}" class="form-control">
                                <div class="text-danger">{{ $errors->first('first_name') }}</div>
                                <br>
                                Segundo Nombre
                                <input type="text" name="second_name" value="{{$employee->second_name}}" class="form-control">
                                <br>
                                Primer Apellido
                                <input type="text" name="last_name" value="{{$employee->last_name}}" class="form-control">
                                <br>
                                Segundo Apellido
                                <input type="text" name="mothers_last_name" value="{{$employee->mothers_last_name}}" class="form-control">
                                <br>
                                Fecha de nacimiento
                                <input type="text" name="birth_date" value="{{$employee->birth_date}}" class="form-control">
                                <br>
                                Lugar de nacimiento
                                <select id="" class="form-control" name="city_birth_id">
                                @foreach($cities as $city)
                                    <option value="{{$city->id}}" @if($employee->city_birth_id == $city->id) selected @endif>{{$city->name}}</option>
                                @endforeach
                                </select>
                                <br>
                                Genero
                                <input type="text" name="gender" value="{{$employee->gender}}" class="form-control">
                            </fieldset>
                            
                        </div>
                        <div class="col-md-6">
                            <fieldset>
                                <legend>Dirección</legend>
                                Localidad <input type="text" name="location" class="form-control" value=" {{ $employee->location }} ">
                                Zona <input type="text" name="zone" class="form-control" value=" {{ $employee->zone }} ">
                                Calle <input type="text" name="street" class="form-control" value=" {{ $employee->street }} ">
                                Numero de puerta <input type="text" name="number" class="form-control" value=" {{ $employee->number }} ">
                            </fieldset>
                            <fieldset>
                                <legend>Datos laborales</legend>
                                    N&uacute;mero de cuenta
                                    <input type="text" name="account_number" value="{{$employee->account_number}}" class="form-control">
                                    <br>
                                    NUA/CUA
                                    <input type="text" name="nua_cua" class="form-control" value="{{$employee->nua_cua}}">
                                    <br>
                                    AFP
                                    <select name="management_entity_id" class="form-control">
                                        @foreach($managements as $management) 
                                            <option value="{{ $management->id }}" @if($management->id == $employee->management_entity_id) selected @endif>{{ $management->name }}</option>
                                        @endforeach                    
                                    </select>
                                    <br>
                                    Caja de salud
                                    <select name="insurance_company_id" class="form-control">
                                        @foreach($insurances as $insurance) 
                                            <option value="{{ $insurance->id }}" @if($employee->insurance_company_id == $insurance->id) selected @endif >{{ $insurance->name }}</option>
                                        @endforeach                    
                                    </select>    
                                    <br>
                                    <button type="submit" class="btn btn-success pull-right"> Guardar</button>
                            </fieldset>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection