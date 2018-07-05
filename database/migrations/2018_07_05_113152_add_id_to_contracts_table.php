<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddIdToContractsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('contracts', function (Blueprint $table) {
            $table->bigInteger('contracts_type_id')->unsigned()->nullable();
            $table->foreign('contracts_type_id')->references('id')->on('contract_types');
            $table->bigInteger('consultancy_id')->unsigned()->nullable();
            $table->foreign('consultancy_id')->references('id')->on('consultancy');
            $table->string('cite_performance')->nullable();
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
            Schema::dropIfExists('contracts_type_id');
            Schema::dropIfExists('consultancy_id');
            Schema::dropIfExists('cite_performance');
        });
    }
}
