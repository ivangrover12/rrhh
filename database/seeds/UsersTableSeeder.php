<?php

use Illuminate\Database\Seeder;

class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $users = [
            ['username' => 'admin', 'password' => Hash::make('admin')],
        ];
        foreach ($users as $user) {
            App\User::create($user);
        }
    }
}
