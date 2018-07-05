@extends('layouts.app') 
@section('title','Crear contrato') 
@section('content')

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-9">
        {{ Breadcrumbs::render('contract_create') }}
    </div>
</div>

<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-lg-6">
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
            <h3>Crear Contrato</h3>
            <form method="POST" action="{{asset('contract')}}">
                {{ csrf_field() }}
                Empleado
                <select id="" name="employee_id" class="form-control">
                    <option></option>
                    @foreach($employees as $employee)
                    <option value="{{$employee->id}}">{{$employee->identity_card.' '.$employee->last_name.' '.$employee->first_name.' '.$employee->second_name}}</option>
                    @endforeach
                </select>
                <br>
                Cargo:
                <select id="" name="position_id" class="form-control">
                    @foreach($position_groups as $p)
                        <optgroup label="{{ $p->name}}">
                            @foreach($p->positions as $position)
                                <option value="{{$position->id}}">{{ $position->name }}</option>
                            @endforeach
                        </optgroup>
                    @endforeach
                </select>
                <br>
                Fecha de inicio
                <input type="date" name="date_start" class="form-control">
                <br>
                Fecha de fin
                <input type="date" name="date_end" class="form-control">
                <br>

                <button type="submit">
                    guardar</button>
            </form>
        </div>
    </div>
</div>
@endsection