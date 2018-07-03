<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Aviso de afiliacion y reingreso del trabajador</title>
    <style>
        html,
        body {
            
        }
        .tabla{
            margin: 0;
            padding: 5px 0px;
            font-family: 'Arial', sans-serif;
            text-align: center;
            
            margin: 1.5cm 0 0 2cm;
        }
        .first{
            margin: 5cm 0 0 0;
        }
        .second{
            margin: 1.6cm 0 0 0;
        }
        .three{
            margin: 1.2cm 0 0 0;
        }
        .four{
            margin: 0.8cm 0 0 0;
        }
        .five{
            margin: 0.4cm 0 0 0;
        }
        .camp{ 
            display: table-cell;
            vertical-align: middle;            
        }
        .separate{
            clear: both;
        }
        .pat{
            width: 5.5cm;
            height:1.2cm;    
        }
        .mat{
            width: 5.5cm;
            height:1.2cm;    
        }            
        .name{
            width: 5.5cm;
            height:1.2cm;    
        }
        .noasegurado{
            width: 5.5cm; 
            height:1.2cm;   
        }
        .day_birth{
            width: 1.8cm; 
            height:1.2cm;   
        }
        .month_birth{
            width: 1.8cm; 
            height:1.2cm;   
        }
        .year_birth{
            width: 1.8cm; 
            height:1.2cm;   
        }
        .gender{
            width: 2.8cm; 
            height:1.2cm;   
        }
        .zone{
            width: 3.6cm; 
            height:1.2cm;   
        }
        .street{
            width: 4.4cm; 
            height:1.2cm;   
        }
        .no{
            width: 2cm; 
            height:1.2cm;   
        }
        .location{
            width: 3.6cm; 
            height:1.2cm;   
        }
        .salary{
            width: 5.6cm; 
            height:1.2cm;  
        }
        .position{
            width: 7.9cm; 
            height: 1.2cm;  
             
        }
        .start{
            width: 8.4cm; 
            height: 1.2cm;  
        }
        .day_end{
            width: 2.1cm; 
            height:0.8cm;   
        }
        .month_end{
            width: 4.2cm;
            height:0.8cm;    
        }
        .year_end{
            width: 2.1cm;
            height:0.8cm;    
        }
        .razon{
            width: 13.5cm;
            height: 1.3cm;    
        }
        .noemp{
            width: 8.5cm;
            height: 1.3cm;    
        }
        .fecha{
            width: 17.1cm;
            height: 0.8cm;    
        }
    </style>

</head>

<body>
<div class="">
    <div class="tabla">
        <div class="first">
            <div class="camp pat"> {{ $contract->employee->last_name }} </div>
            <div class="camp mat"> {{ $contract->employee->mothers_last_name }} </div>
            <div class="camp name"> {{ $contract->employee->first_name }} {{ $contract->employee->second_name }} </div>
            <div class="camp noasegurado">  </div>
            
        </div>
        <div class="separate"></div>
        <div class="second">
            <div class="camp day_birth"> {{ date('d', strtotime($contract->employee->birth_date)) }} </div>
            <div class="camp month_birth"> {{ date('m', strtotime($contract->employee->birth_date)) }} </div>
            <div class="camp year_birth"> {{ date('Y', strtotime($contract->employee->birth_date)) }} </div>
            <div class="camp gender"> {{ $contract->employee->gender }} </div>
            <div class="camp zone"> {{ $contract->employee->zone }} </div>
            <div class="camp street"> {{ $contract->employee->street }} </div>
            <div class="camp no"> {{ $contract->employee->number }} </div>
            <div class="camp location"> {{ $contract->employee->location }} </div>
        </div>
        <div class="separate"></div>
        <div class="three">
            <div class="camp salary"> {{ $contract->position->charge->base_wage }} </div>
            <div class="camp position"> {{ $contract->position->name }} </div>
            <div class="camp start"> 
                <div>&nbsp;</div> 
                <div class="camp day_end"> {{ date('d', strtotime($contract->date_start)) }} </div>
                <div class="camp month_end"> {{ Util::getMonthEs(date('m', strtotime($contract->date_start))) }} </div>
                <div class="camp year_end"> {{ date('Y', strtotime($contract->date_start)) }} </div>
            </div>
        </div>
        <div class="separate"></div>
        <div class="four">
            <div class="camp razon"> {{ $razon }} </div>
            <div class="camp noemp"> {{ $noemp }} </div>
        </div>
        <div class="separate"></div>
        <div class="five">
            <div class="camp fecha"> {{ $fecha }} </div>
        </div>
    </div>
</div>
</body>
</html>