<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Contract extends Model
{
    use SoftDeletes;

    protected $dates = ['deleted_at'];

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
