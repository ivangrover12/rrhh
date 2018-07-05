<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateConsultancy extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('consultancy', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('modality_id');
            $table->integer('employee_id');
            $table->string('name');            
            $table->string('cite_request');
            $table->string('date_cite_request');
            $table->string('authorization_note');
            $table->string('date_authorization_note');
            $table->string('certification_budget');
            $table->string('date_certification_budget');
            $table->string('year_poa');
            $table->string('certification_upom');
            $table->string('date_certification_upom');
            $table->string('note_award');
            $table->string('date_note_award');
            $table->string('report_recommendation')->nullable();
            $table->string('date_report_recommendation')->nullable();
            $table->string('object');
            $table->string('months');
            $table->string('location')->nullable();
            $table->decimal('total_amountr', 8, 2)->nullable();
            $table->text('obligations');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('consultancy');
    }
}
