@extends('layouts.app')
@section('content')
<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-9">
        {{ Breadcrumbs::render('payroll', $year, $month) }}
    </div>
</div>
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-lg-12">
            <div class="text-center ">
                <form action="/payroll" method="POST">
                    <input type="hidden" value="{{ $procedure->month->name}}" name="month">
                    <input type="hidden" value="{{ $procedure->year }}" name="year">
                    {{ csrf_field() }}
                <payroll-index :edit="false" :procedure="{{ $procedure }}"></payroll-index>
                <div style="clear: both;"></div>
                <button class="btn btn-primary" type="submit"> <i class="fa fa-save"></i> Guardar</button>
                </form>
            </div>
        </div>
    </div>
</div>

@endsection
