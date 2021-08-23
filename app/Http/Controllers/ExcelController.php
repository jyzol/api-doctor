<?php

namespace App\Http\Controllers;

//require_once "vendor/autoload.php";

use Illuminate\Http\Request;
use PhpOffice\PhpSpreadsheet\IOFactory;
use PhpOffice\PhpSpreadsheet\Shared\Date;
use Illuminate\Support\Facades\DB;

class ExcelController extends Controller{
    function cargarExcel(Request $req){
        //$doc = $req->file('doc');
        copy("http://127.0.0.1/176288.xls","./temp.xls");
        $doc = "./temp.xls";

        $documento = IOFactory::load($doc);
        //$totalDeHojas = $documento->getSheetCount();

        $hojaActual = $documento->getSheet(0);
        
        $columnas = [
            "liquidacion" => "A",
            "nombre_medico" => "B",
            "cliente" => "D",
            "c" => "F",
            "admision" => "G",
            "fecha_atencion" => "I",
            "nro_historia" => "K",
            "paciente" => "M",
            "tarifa" => "O",
            "concepto" => "P",
            "cod_sede" => "S",
            "sede" => "T",
            "cod_prov" => "W",
            "proveedor" => "X",
            "importe_total" => "AA",
        ];
        

        $fila = [
            "liquidacion" => "",
            "nombre_medico" => "",
            "cliente" => "",
            "c" => "",
            "admision" => "",
            "fecha_atencion" => "",
            "nro_historia" => "",
            "paciente" => "",
            "tarifa" => "",
            "concepto" => "",
            "cod_sede" => "",
            "sede" => "",
            "cod_prov" => "",
            "proveedor" => "",
            "importe_total" => "",
        ];

        $i = 4;

        //echo "<table border='1'>";
        
        //for($i=4;$i<=8;$i++){
        while($hojaActual->getCell("A".strval($i))!=""){
            //echo "<tr>";
            foreach ($columnas as $key => $value) {
                $cod = $value . strval($i);
                $celda = $hojaActual->getCell($cod);
                $valorRaw = $celda->getValue();
                $valorRaw = trim($valorRaw);

                if($key == "fecha_atencion"){
                    $valorRaw = date_format(Date::excelToDateTimeObject($valorRaw),"Y-m-d");
                }

                if($key == "importe_total"){
                    $valorRaw = floatval($valorRaw);
                }

                $fila[$key] = $valorRaw;

                //echo "<td>".$valorRaw."</td>";
            }
            DB::table('loadconsultas')->insert($fila);
            echo $i;
            print_r($fila);
            print "<br /><br />";
            $i++;
            //echo "</tr>";
        }
        //echo "</table>";
        unlink("./temp.xls");
    }
}
