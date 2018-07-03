
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
        .doc{
            font: 14pt "Times New Roman", "Times";
            text-align: justify;
        }
        .head{
            font-weight: bold;
            text-decoration: underline;            
        }
        .title-text{
            font-weight: bold;
        }
        .up{
            text-transform: uppercase;
        }
        .center{
            text-align: center;
        }
        .firma{
            width: 900px;
            height: 150px;
            display: table-cell;
            vertical-align: bottom;
        }
        .title1{
            width: 500px;
        }
    </style>
</head>
<body>
<div class="doc">
    <div style="width: 135px;float: left">&nbsp;</div>  
    <div class="title-text center" style="width: 500px;float: left">CONTRATO ADMINISTRATIVO DE CONSULTORÍA INDIVIDUAL DE LÍNEA</div>
    <div style="clear: both;"></div>
    <div class="title-text center">“CONSULTOR EN LÍNEA-{{ strtoupper($contract->position->name) }}” </div>
    <div class="head center"> CONSULT Nº {{ $contract->number_contract }} </div>
    <div class="content">
        <p class="text" style="text-indent: 5em">
            Conste por el presente Contrato Administrativo para la prestación de servicios de consultoría individual en línea, que celebran por una parte la MUTUAL DE SERVICIOS AL POLICÍA (MUSERPOL), con domicilio en la avenida 6 de agosto No. 2354, de la ciudad de La Paz, representado legalmente por el CNL. DESP. {{ Util::fullName($mae->employee) }} con C.I. No. {{ $mae->employee->identity_card.' '.$mae->employee->city_identity_card->shortened }} en su calidad de <span class="up">{{ $mae->position->name }}</span>, designado mediante Resolución Suprema No. 16382 de 31 de agosto de 2015, y el LIC. MSC. { Util::fullName($daa->employee) }} con C.I. No.  {{ $daa->employee->identity_card.' '.$daa->employee->city_identity_card->shortened }} en su calidad de RESPONSABLE DEL PROCESO DE CONTRATACIÓN DE APOYO NACIONAL A LA PRODUCCIÓN Y EMPLEO - RPA, designado mediante Resolución Administrativa No.011/2018 de fecha 05 de marzo de 2018, que en adelante se denominará la ENTIDAD; y por otra parte <span class="title-text"> {{ Util::fullName($contract->employee) }} </span> con <span class="title-text"> C.I. No. {{ $contract->employee->identity_card.' '.$contract->employee->city_identity_card->shortened }}</span> con domicilio en {{ $contract->employee->street }} N° {{ $contract->employee->number }}, Z. {{ $contract->employee->zone }} de la ciudad de {{ $contract->employee->location }}, que en adelante se denominará el CONSULTOR, quienes celebran y suscriben el presente Contrato Administrativo, de acuerdo a los términos y condiciones siguientes:
        </p>
        <p>
            <span class="title-text">CLÁUSULA PRIMERA (ANTECEDENTES). -</span><br>
            Mediante Decreto Supremo N° 1446 de fecha 19 de diciembre de 2012, se creó la Mutual de Servicios al Policía – MUSERPOL, Institución Pública Descentralizada de duración indefinida y patrimonio propio, con autonomía de gestión administrativa, financiera, legal y técnica, bajo tuición del Ministerio de Gobierno.

        </p>
        

        <p class="firma center title-text">
            EN DESARROLLO ...........
        </p>
    </div>
</div>    
</body>
</html>