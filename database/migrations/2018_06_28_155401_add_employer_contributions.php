<?php
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;
class AddEmployercontributions extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('procedures', function (Blueprint $table) {
            $table->decimal('contribution_insurance_company', 8, 2)->default(10);
            $table->decimal('contribution_professional_risk', 8, 2)->default(1.71);
            $table->decimal('contribution_employer_solidary', 8, 2)->default(3);
            $table->decimal('contribution_employer_housing', 8, 2)->default(2);
        });
    }
    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('procedures', function (Blueprint $table) {
            $table->dropColumn(['contribution_insurance_company', 'contribution_professional_risk', 'contribution_employer_solidary', 'contribution_employer_housing']);
        });
    }
}