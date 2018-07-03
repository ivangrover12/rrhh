<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddToEmployeesTables extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('employees', function (Blueprint $table) {
            $table->string('location')->nullable();
            $table->string('zone')->nullable();
            $table->string('street')->nullable();
            $table->string('number')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('employees', function (Blueprint $table) {
            Schema::dropIfExists('location');
            Schema::dropIfExists('zone');
            Schema::dropIfExists('street');
            Schema::dropIfExists('number');
        });
    }
}
