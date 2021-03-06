<?php

use Illuminate\Database\Seeder;

class CompaniesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $companies = [
            [
                'name' => 'MUTUAL DE SERVICIOS AL POLICIA',
                'address' => 'Av. 6 de Agosto No. 2354 - Zona Sopocachi',
                'tax_id_number' => 234578021,
            ],
        ];
        foreach ($companies as $company) {
            App\Company::create($company);
        }
    }
}
