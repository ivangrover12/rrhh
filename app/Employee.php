<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Helpers\Util;
use Illuminate\Database\Eloquent\SoftDeletes;

class Employee extends Model
{
    use SoftDeletes;
    protected $dates = ['deleted_at'];

    public function employee_type()
    {
        return $this->belongsTo(EmployeeType::class,'employee_type_id','id');
    }

    public function city_identity_card()
    {
        return $this->belongsTo(City::class, 'city_identity_card_id', 'id');
    }

    public function city_birth()
    {
        return $this->belongsTo(City::class, 'city_birth_id', 'id');
    }

    public function management_entity()
    {
        return $this->belongsTo(ManagementEntity::class, 'management_entity_id', 'id');
    }

    public function insurance_company()
    {
        return $this->belongsTo(InsuranceCompany::class, 'insurance_company_id', 'id');
    }

    public function contracts()
    {
        return $this->hasMany(Contract::class);
    }

    public function fullName($style="uppercase", $order="name_first")
    {
        return Util::fullName($this, $style, $order);
    }

    public function lastContract()
    {
        return $this->contracts()->orderBy('date_start', 'DESC')->first();
    }

}
