<?php

use Illuminate\Database\Seeder;

class ContractTypesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $names = [
            ['name' => 'Libre Nombramiento'],
            ['name' => 'Eventual nuevo'],
            ['name' => 'Eventual recontratacion'],
            ['name' => 'Consultor']
        ];
        foreach ($names as $name) {        	
            App\ContractType::create($name);
        }
    }
}
