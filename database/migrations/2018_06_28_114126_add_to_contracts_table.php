<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddToContractsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('contracts', function (Blueprint $table) {
            $table->string('number_insurance')->nullable();
            $table->string('number_contract')->nullable();
            $table->string('cite_rrhh')->nullable();            
            $table->date('cite_rrhh_date')->nullable();
            $table->string('numer_announcement')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('contracts', function (Blueprint $table) {
            Schema::dropColumn('number_insurance');
            Schema::dropColumn('number_contract');
            Schema::dropColumn('cite_rrhh');
            Schema::dropColumn('cite_rrhh_date');
            Schema::dropColumn('numer_announcement');
        });
    } 
}
