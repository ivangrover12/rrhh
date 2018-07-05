<?php

use Illuminate\Database\Seeder;

class ContractJobScheduleTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $contracts = App\Contract::all();
        $schedules = App\JobSchedule::all();

        foreach ($contracts as $contract) {
            $contract->schedules()->attach($schedules[0]);
            $contract->schedules()->attach($schedules[1]);
        }
    }
}
