<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class ChangeBalanceDataToPayrollsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('payrolls', function (Blueprint $table) {
            DB::statement('alter table payrolls alter column next_month_balance type integer using next_month_balance::integer');
            DB::statement('alter table payrolls alter column previous_month_balance type integer using previous_month_balance::integer');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('payrolls', function (Blueprint $table) {
            DB::statement('alter table payrolls alter column next_month_balance type numeric(8,2) using next_month_balance::numeric');
            DB::statement('alter table payrolls alter column previous_month_balance type numeric(8,2) using previous_month_balance::numeric');
        });
    }
}
