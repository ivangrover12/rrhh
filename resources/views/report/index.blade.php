@extends('layouts.app') 
@section('content')
<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-9">
        {{-- Breadcrumbs::render('payroll_edit', $year, $month) --}}
    </div>
</div>
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-lg-12">
            <div id="accordion">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">
                            <button class="btn btn-primary" data-toggle="collapse" data-target="#collapseContracts" aria-expanded="true" aria-controls="collapseContracts">
                            REPORTE DE CONTRATOS GENERADOS
                            </button>
                        </h5>
                    </div>

                    <div id="collapseContracts" class="collapse show" data-parent="#accordion">
                        <div class="card-body">
                            <form method="get" action="{{url('/report/print/contracts')}}"> 
                                <div class="form-inline">
                                    <div class="form-group col-lg-2">
                                        <label for="print_contracts_date_from">Desde</label>
                                        <input type="date" name="from" class="form-control" id="print_contracts_date_from" value="">
                                    </div>
                                    <div class="form-group col-lg-2">
                                        <label for="print_contracts_date_to">Hasta</label>
                                        <input type="date" name="to" class="form-control" id="print_contracts_date_to" value="">
                                    </div>
                                    <button type="submit" class="btn btn-success col-lg-1"><i class="glyphicon glyphicon-search"></i> Buscar</button>
                                </div>
                                @if ($errors->any())
                                    <div class="col-lg-12">
                                        <div class="alert alert-danger form-group col-lg-6">
                                            {{ implode('', $errors->all(':message')) }}
                                        </div>
                                    </div>
                                @endif
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection