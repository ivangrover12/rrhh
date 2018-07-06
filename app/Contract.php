<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Contract extends Model
{
    public function payrolls()
    {
        return $this->hasMany(Payroll::class);
    }
    public function employee()
    {
        return $this->belongsTo(Employee::class);
    }
    public function position()
    {
        return $this->belongsTo(Position::class);
    }

    public function schedules()
    {
        return $this->belongsToMany('App\JobSchedule')->withTimestamps();
    }
    public function contracttype()
    {
        return $this->belongsTo('App\ContractType','contracts_type_id','id');
    }
}
