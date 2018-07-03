@extends('layouts.app') 
@section('title','Editar contrato') 
@section('content')

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-9">
        ruta
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
            <h3>Editar Contrato</h3>
            <form method="POST" action="{{action('ContractController@update', $contract->id)}}">
                {{ csrf_field() }}
                <input name="_method" type="hidden" value="PATCH">
                Empleado
                <input type="text" class="form-control" disabled value="{{$employee->fullName()}}"  >
                <br>
                CI
                <input type="text" class="form-control" disabled value="{{$employee->identity_card}}"  >
                {{-- <select id="" name="employee_id" class="form-control">
                    <option></option>
                    @foreach($employees as $employee)
                    <option value="{{$employee->id}}" @if($employee->id == $contract->employee_id) SELECTED @endif>{{$employee->identity_card.' '.$employee->last_name.' '.$employee->first_name.' '.$employee->second_name}}</option>
                    @endforeach
                </select> --}}
                <br>
                Cargo:
                <select id="" name="position_id" class="form-control">
                    @foreach($position_groups as $p)
                        <optgroup label="{{ $p->name}}">
                            @foreach($p->positions as $position)
                                @if($position->id == $contract->position_id)
                                    <option value="{{$position->id}}" selected>{{ $position->name }}</option>
                                @else
                                    <option value="{{$position->id}}">{{ $position->name }}</option>
                                @endif
                            @endforeach
                        </optgroup>
                    @endforeach
                </select>
                <br>
                Fecha de inicio
                <input type="date" name="date_start" value="{{ $contract->date_start }}" class="form-control">
                <br>
                Fecha de fin
                <input type="date" name="date_end" value="{{ $contract->date_end }}" class="form-control">
                Numero de asegurado <i class="fa fa-comment" type="button" data-toggle="tooltip" data-placement="top" title="Ejemplo: 11-1111-XXX"></i>
                <input type="text" name="number_insurance" value="{{ $contract->number_insurance }}" class="form-control">
                Numero de Contrato <i class="fa fa-comment" type="button" data-toggle="tooltip" data-placement="top" title="Ejemplo: 104/2018"></i>
                <input type="text" name="number_contract" value="{{ $contract->number_contract }}" class="form-control">
                Cite de Resursos Humanos <i class="fa fa-comment" type="button" data-toggle="tooltip" data-placement="top" title="Ejemplo: RR.HH.-120/2018"></i>
                <input type="text" name="cite_rrhh" value="{{ $contract->cite_rrhh }}" class="form-control">
                Fecha del cite 
                <input type="date" name="cite_rrhh_date" value="{{ $contract->cite_rrhh_date }}" class="form-control">
                Numero de convocatoria <i class="fa fa-comment" type="button" data-toggle="tooltip" data-placement="top" title="Ejemplo: URH-028"></i>
                <input type="text" name="numer_announcement" value="{{ $contract->numer_announcement }}" class="form-control">
                
                <br>
                <label for="">Contrato Vigente: </label>
                @if ($contract->status)
                    <input style="transform: scale(1.5);"  type="checkbox" checked name="status">
                @else
                    <input style="transform: scale(1.5);"  type="checkbox" name="status">
                @endif
                <br>
                <button type="submit">guardar</button>
            </form>
        </div>
    </div>
</div>
@endsection