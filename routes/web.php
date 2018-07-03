<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('home');
});

Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');
Route::resource('employee','EmployeeController');
Route::get('employee_data', 'EmployeeController@getEmployeeDatatable' )->name('employee_list');


Route::get('employee/{employee}/payroll','PayrollController@employee_payroll');
Route::get('payroll','PayrollController@index');
Route::get('payroll/{year}/{month}','PayrollController@create')->name('create_payroll');
Route::get('payroll/{year}/{month}/edit','PayrollController@edit')->name('edit_payroll');
Route::post('payroll','PayrollController@store');
Route::get('payroll/print/{year}/{month}', 'PayrollController@print')->where(['params'=>'.*'])->name('print_payroll');


// Route::resource('report','ReportController');
Route::get('report/{year}/{month}','ReportController@getExcel')->name('report_excel');
Route::get('report/print/contracts/{from}/{to}', 'ReportController@printContracts')->name('report_print_contracts');
Route::resource('contract','ContractController');

/*  tickets */
Route::get('ticket/print/{year}/{month}', 'TicketController@print')->name('print_ticket');