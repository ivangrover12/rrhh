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
        <div class="col-md-12">
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
            <h3>REGISTRO DE EMPLEADO</h3>
            <form method="POST" action="{{asset('employee')}}">
                <div class="col-md-3">
                    &nbsp;
                </div>
                <div class="col-md-6">
                    {{ csrf_field() }}
                    Tipo de empelado
                    <select id="" name="employee_type_id" class="form-control">
                        <option></option>
                        @foreach($employee_types as $employee_type)
                        <option value="{{$employee_type->id}}">{{$employee_type->name}}</option>
                        @endforeach
                    </select>
                </div>
                <div class="col-md-3">
                    &nbsp;
                </div>
                <br>
                <div class="col-md-6">
                    <fieldset>
                        <legend>Datos personales</legend>
                        CI:
                        <input type="text" class="form-control" name="identity_card">
                        <br>
                        Expedici&oacute;n
                        <select id="" class="form-control" name="city_identity_card_id">
                            <option></option>
                            @foreach($cities as $city)
                            <option value="{{$city->id}}">{{$city->name}}</option>
                            @endforeach
                        </select>
                        <br>
                        Primer Nombre
                        <input type="text" name="first_name" class="form-control">
                        <br>
                        Segundo Nombre
                        <input type="text" name="second_name" class="form-control">
                        <br>
                        Primer Apellido
                        <input type="text" name="last_name" class="form-control">
                        <br>
                        Segundo Apellido
                        <input type="text" name="mothers_last_name" class="form-control">
                        <br>
                        Fecha de nacimiento
                        <input type="date" name="birth_date" class="form-control" min="1950-01-01" max="2002-01-01">
                        <br>
                        Lugar de nacimiento
                        <select id="" class="form-control" name="city_birth_id">
                            <option></option>
                            @foreach($cities as $city)
                            <option value="{{$city->id}}">{{$city->name}}</option>
                            @endforeach
                        </select>
                        <br>
                        Sexo                
                        <select class="form-control" name="gender">
                            <option></option>
                            <option value="M">Masulino</option>
                            <option value="F">Femenino</option>                    
                        </select>
                    </fieldset>
                </div>
                <div class="col-md-6">
                    <fieldset>
                        <legend>Dirección</legend>
                        Localidad <input type="text" name="location" class="form-control">
                        Zona <input type="text" name="zone" class="form-control">
                        Calle <input type="text" name="street" class="form-control">
                        Numero de puerta <input type="text" name="number" class="form-control">
                    </fieldset>
                    <hr>
                    <fieldset>
                        <legend>Datos laborales</legend>
                        N&uacute;mero de cuenta
                        <input type="text" name="account_number" class="form-control">
                        <br>
                        NUA/CUA
                        <input type="text" name="nua_cua" class="form-control">
                        <br>
                        AFP
                        <select name="management_entity_id" class="form-control">
                            <option></option>
                            @foreach($managements as $management) 
                                <option value="{{ $management->id }}">{{ $management->name }}</option>
                            @endforeach                    
                        </select>
                        <br>
                        Caja de salud
                        <select name="insurance_company_id" class="form-control">
                            <option></option>
                            @foreach($insurances as $insurance) 
                                <option value="{{ $insurance->id }}">{{ $insurance->name }}</option>
                            @endforeach                    
                        </select>
                    </fieldset>
                    <br>
                    <button type="submit" class="btn btn-success pull-right">Resgistrar</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection