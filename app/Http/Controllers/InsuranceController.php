<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Contract;

use \Milon\Barcode\DNS1D;
use \Milon\Barcode\DNS2D;
use App\Helpers\Util;
use Carbon\Carbon;
use Log;

class InsuranceController extends Controller
{
    public function printhigh($id)
    {
        $contract = Contract::where('id',$id)->first();
        
        $meses = ['','Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];
        
        $file_name= "Seguro.pdf";
        $data = [
            'contract' => $contract,
            'razon' => 'MUTUAL DE SERVICIOS AL POLICIA',
            'noemp' => '01-720-0025',
            'fecha' => 'La Paz, '.date('d').' de '.$meses[(int)date('m')].' del '.date('Y')
        ];
        return \PDF::loadView('insurance.printhigh',$data)
            ->setOption('page-width', '216')
            ->setOption('page-height', '279')
            ->setOption('margin-top',0)
            ->setOption('margin-bottom', 0)
            ->setOption('margin-left', 4)
            ->setOption('margin-right', 4)
            ->setOption('encoding', 'utf-8')
            ->stream($file_name);
    }
    public function printlow($id)
    {
        $contract = Contract::where('id',$id)->first();
        
        $meses = ['','Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];
        
        $file_name= "Seguro.pdf";
        $data = [
            'contract' => $contract,
            'razon' => 'MUTUAL DE SERVICIOS AL POLICIA',
            'noemp' => '01-720-0025',
            'fecha' => 'La Paz, '.date('d').' de '.$meses[(int)date('m')].' del '.date('Y')
        ];
        return \PDF::loadView('insurance.printlow',$data)
            ->setPaper('letter')
            ->setOption('margin-top',0)
            ->setOption('margin-bottom', 0)
            ->setOption('margin-left', 4)
            ->setOption('margin-right', 4)
            ->setOption('encoding', 'utf-8')
            ->stream($file_name);
    }
}

