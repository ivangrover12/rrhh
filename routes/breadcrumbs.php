<?php

Breadcrumbs::register('payroll_index', function ($breadcrumbs) {
    $breadcrumbs->push('Planillas');
});
Breadcrumbs::register('payroll', function ($breadcrumbs, $year, $month) {
    $breadcrumbs->push('Planilla de '.$year.' - '.$month);
});
Breadcrumbs::register('payroll_edit', function ($breadcrumbs, $year, $month) {
    $breadcrumbs->push('Edición de la planilla de '.$year.' - '.$month);
});
Breadcrumbs::register('contract_create', function ($breadcrumbs) {
    $breadcrumbs->push('Crear contrato');
});
Breadcrumbs::register('contract_edit', function ($breadcrumbs) {
    $breadcrumbs->push('Editar contrato');
});
Breadcrumbs::register('contract_list', function ($breadcrumbs) {
    $breadcrumbs->push('Contratos');
});
Breadcrumbs::register('employee_create', function ($breadcrumbs) {
    $breadcrumbs->push('Alta de personal');
});
Breadcrumbs::register('employee_edit', function ($breadcrumbs) {
    $breadcrumbs->push('Editar empleado');
});
Breadcrumbs::register('employee_list', function ($breadcrumbs) {
    $breadcrumbs->push('Empleados');
});
Breadcrumbs::register('reports', function ($breadcrumbs) {
    $breadcrumbs->push('Reportes');
});
Breadcrumbs::register('payroll_txt_error', function ($breadcrumbs, $message = '') {
    $breadcrumbs->push($message);
});