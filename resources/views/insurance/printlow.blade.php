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
        .zero{
            margin: 3.5cm 0 0 0;
        }
        .first{
            margin: 2cm 0 0 0;
        }
        .second{
            margin: 1.2cm 0 0 0;
        }
        .three{
            margin: 1.4cm 0 0 0;
        }
        .four{
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
        .salary{
            width: 5.5cm; 
            height:2cm;    
        }
        .motivo{
            width: 5.5cm; 
            height: 2cm;                 
        }
        .start{
            width: 11cm; 
            height: 2cm;    
        }
        .day_end{
            width: 2.5cm; 
            height:1cm;     
        }
        .month_end{
            width: 6cm;
            height:1cm;      
        }
        .year_end{
            width: 2.5cm;
            height:1cm;      
        }
        .razon{
            width: 16.5cm;
            height: 1.2cm;      
        }
        .noemp{
            width: 5.5cm;
            height: 1.2cm;      
        }
        .fecha{
            width: 16.5cm;
            height: 1.2cm;      
        }
        .ci{
            width: 22cm;
            text-align: right;  
        }
    </style>
</head>
<body>
<div class="">
    <div class="tabla">
        <div class="zero">
            <div class="camp ci"> CI: {{ $contract->employee->identity_card }} {{ $contract->employee->city_identity_card->shortened }} </div>
        </div>
        <div class="first">
            <div class="camp pat"> {{ $contract->employee->last_name }} </div>
            <div class="camp mat"> {{ $contract->employee->mothers_last_name }} </div>
            <div class="camp name"> {{ $contract->employee->first_name }} {{ $contract->employee->second_name }} </div>
            <div class="camp noasegurado"> {{ $contract->number_insurance }} </div>
            
        </div>
        <div class="separate"></div>
        <div class="second">
            <div class="camp salary"> {{ $contract->position->charge->base_wage }} </div>            
            <div class="camp start"> 
                <div style="height: 1cm">&nbsp;</div> 
                <div class="camp day_end"> {{ date('d', strtotime($contract->date_end)) }} </div>
                <div class="camp month_end"> {{ Util::getMonthEs(date('m', strtotime($contract->date_end))) }} </div>
                <div class="camp year_end"> {{ date('Y', strtotime($contract->date_end)) }} </div>
            </div>
            <div class="camp motivo"> {{ $contract->retirement_reason }} </div>
        </div>
        <div class="separate"></div>
        <div class="three">
            <div class="camp razon"> {{ $razon }} </div>
            <div class="camp noemp"> {{ $noemp }} </div>
        </div>
        <div class="separate"></div>
        <div class="four">
            <div class="camp fecha"> {{ $fecha }} </div>
        </div>        
    </div>
</div>    
</body>
</html>