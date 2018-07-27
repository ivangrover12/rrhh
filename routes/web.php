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
Route::group(['middleware' => 'auth'], function(){
    Route::get('/','EmployeeController@index');
    
    Route::get('/home','EmployeeController@index')->name('home');
    
    Route::get('employee/list','EmployeeController@list');
    
    Route::resource('employee','EmployeeController');
    Route::get('employee_data', 'EmployeeController@getEmployeeDatatable' )->name('employee_list');   
    Route::get('employee/status/{id}', 'EmployeeController@status')->name('status_employee');
    Route::get('employee/{employee}/payroll','PayrollController@employee_payroll');
  
    Route::get('payroll/addmonth','PayrollController@addmonth');
    Route::get('payroll/show_payroll_month/{id}','PayrollController@show_payroll_month');
    Route::get('payroll/tribute_calculation/{id}','PayrollController@tribute_calculation');
    Route::get('payroll','PayrollController@index');
    Route::get('payroll/{year}/{month}','PayrollController@create')->name('create_payroll');
    Route::get('payroll/{year}/{month}/edit','PayrollController@edit')->name('edit_payroll');
    Route::post('payroll','PayrollController@store');
    Route::get('payroll/print/pdf/{year}/{month}', 'PayrollController@print_pdf')->name('print_pdf_payroll');
    Route::get('payroll/print/txt/{year}/{month}', 'PayrollController@print_txt')->name('print_txt_payroll');
    Route::get('payroll/ovt/{year}/{month}' , 'PayrollController@print_ovt')->name('print_ovt_payroll');

    // Route::resource('report','ReportController');
    Route::get('report/','ReportController@index');
    Route::get('report/print/contracts', 'ReportController@printContracts')->name('report_print_contracts');
    Route::get('report/{year}/{month}','ReportController@getExcel')->name('report_excel');
    
    Route::get('contract/list/{status}','ContractController@list');
    Route::get('contract/checkrenovate', 'ContractController@checkrenovate')->name('checkrenovate_contract');
    Route::post('contract/renovate', 'ContractController@renovate');
    Route::get('contract/print/{id}', 'ContractController@print')->name('print_contract');
    Route::get('contract/delete/{id}', 'ContractController@delete')->name('delete_contract');
    Route::get('contract/month_salary_calculation', 'ContractController@month_salary_calculation');    
    Route::resource('contract','ContractController');
    
    /*  tickets */
    
    Route::get('ticket/print/{year}/{month}', 'TicketController@print')->name('print_ticket');
    
    /*	asurance	*/
    Route::get('insurance/printhigh/{id}', 'InsuranceController@printhigh')->name('print_high_insurance');
    Route::get('insurance/printlow/{id}', 'InsuranceController@printlow')->name('print_low_insurance');

    Route::get('user/profile/{user_id}', 'UserController@index')->name('user_profile');
    Route::post('user/reset_password', 'UserController@update')->name('user_reset_password');
});

Auth::routes();

Route::get('logout', '\App\Http\Controllers\Auth\LoginController@logout');
