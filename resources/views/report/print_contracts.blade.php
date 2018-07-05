<?php
  use \App\Helpers\Util;
?>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>{{ $title->name }}</title>
        @if (Config::get('app.debug'))
            <style>
                <?php include public_path('css/all.css') ?>
            </style>
        @else
            <link rel="stylesheet" type="text/css" href="{{ asset('css/all.css') }}"></link>
        @endif
    </head>

    <body>
        <div class="header-center">
            <h2>
                {{ $title->name }}
            </h2>
        </div>

        <table align="center">
            <thead>
                <tr>
                    <th width="1%">N°</th>
                    <th width="20%">NOMBRE Y APELLIDO</th>
                    <th width="10%">CARGO QUE OCUPA</th>
                    <th width="10%">PUESTO</th>
                    <th width="10%">ÁREA</th>
                    <th width="2%">SUELDO MENSUAL</th>
                    <th width="2%">MONTO TOTAL</th>
                    <th width="5%">INICIO DE CONTRATO</th>
                    <th width="5%">FIN DE CONTRATO</th>
                    <th width="1%">ITEM</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($employees as $i => $employee)
                <tr>
                    <td>{{ ++$i }}</td>
                    <td>{{ $employee->full_name }}</td>
                    <td>{{ mb_strtoupper($employee->position) }}</td>
                    <td>{{ $employee->charge }}</td>
                    <td>{{ $employee->position_group }}</td>
                    <td>{{ number_format($employee->base_wage, 0) }}</td>
                    <td>{{ Util::format_number($employee->total_amount, 2, ',', '.') }}</td>
                    <td>{{ $employee->date_start }}</td>
                    <td>{{ $employee->date_end }}</td>
                    <td>{{ $employee->item }}</td>
                </tr>
                @endforeach
            </tbody>
        </table>
    </body>

</html>