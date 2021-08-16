<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Twilio\Rest\Client; 

class UserController extends Controller{
    function login(Request $req){
        $username =  $req->input('userLogin');
        $password = $req->input('passLogin');

        if(!empty($username)){
            $user = DB::table('usuarios')->where('nom_usuario',$username)->first();
            if(!empty($user)){
                if($user->clave != $password){
                    echo "Error";
                }else{
                    $doctor = DB::table('doctores')->where('id_doctor',$user->id_doctor)->get();
                    echo json_encode($doctor[0]);
                }
            }else{
                echo "Error";
            }
            
        }else{
            echo "Error";
        }
        
    }

    function getCode(Request $req){
        $username =  $req->input('userLogin');
        $phonenumber =  $req->input('phoneCode');
        //$password = $req->input('passLogin');

        $gen_pass = random_int(100000,999999);

        $affected = DB::table('usuarios')->where('nom_usuario', $username)->update(['clave' => $gen_pass]);

        if(!empty($affected)){
            $sid    = env('TWILIO_SID');
            $token  = env('TWILIO_TOKEN'); 
            $twilio = new Client($sid, $token); 
 
            $message = $twilio->messages 
                            ->create("+51{$phonenumber}", // to 
                                array(  
                                    "messagingServiceSid" => env('TWILIO_MSID'),      
                                "body" => "Clave de acceso para {$username}: {$gen_pass}"
                            )
                        );
            print($message->sid);
            print($phonenumber);
            $usr = DB::table('usuarios')->where('nom_usuario',$username)->first();
            echo json_encode($usr);
        }else{
            echo "error";
        }
    }

    function logout(Request $req){
        $id =  $req->input('idLogout');
        //$password = $req->input('passLogin');

        $gen_pass = random_int(100000,999999);

        $affected = DB::table('usuarios')->where('id_doctor', $id)->update(['clave' => $gen_pass]);

        if(!empty($affected)){
            $usr = DB::table('usuarios')->where('id_doctor',$id)->first();
            echo json_encode($usr);
        }else{
            echo "error";
        }
    }


    function registrar(Request $req){
        $nombres =  $req->input('nombres');
        $appat = $req->input('appat');
        $apmat = $req->input('apmat');
        $dni = $req->input('dni');
        $correo = $req->input('correo');
        $telefono = $req->input('telefono');
        $direccion = $req->input('direccion');
        $especialidad = $req->input('especialidad');
        $ruc = $req->input('ruc');
        $clavesol = $req->input('clavesol');
        $solpass = $req->input('solpass');
        $usuario = $req->input('usuario');
        $pass = $req->input('pass');

        try {
            $id = DB::table('doctores')->insertGetId([
                'nombres' => $nombres,
                'ap_pat' => $appat,
                'ap_mat' => $apmat,
                'correo' => $correo,
                'telefono' => $telefono,
                'direccion' => $direccion,
                'especialidad' => $especialidad,
                'dni' => $dni,
                'ruc' => $ruc,
                'clave_sol' => $clavesol,
                'pass_sol' => $solpass
            ]);

            DB::table('usuarios')->insert([
                'id_doctor' => $id,
                'tipo_usuario' => 'personal',
                'nom_usuario' => $usuario,
                'clave' => $pass
            ]);
        } catch (\Exception $e) {
            
        }

        echo 'Éxito';
    }

    function actruc(Request $req){
        $ruc = $req->input('ruc');
        $usuario_sunat = $req->input('usuariosunat');
        $clave_sunat = $req->input('clavesunat');

        try {
            $affected = DB::table('doctores')
                        ->where('RUC', $ruc)            
                        ->update([
                            'USUARIO_SUNAT' => $usuario_sunat,
                            'CLAVE_SUNAT' => $clave_sunat
                        ]);
        } catch (\Exception $e) {
            echo "Error";
        }
        if($affected!=0){
            echo $affected;
        }else{
            echo "Error";
        }
        
    }

    function consultaDoctor(Request $req){
        $doctor = $req->input('doctor');
        $doctor = intval($doctor);

        $consultas = DB::table('consultas')->where('id_doctor',$doctor)->get();

        //echo $consultas;

        //echo "\n";

        return json_encode($consultas);
        //return response()->json(['success' => true, 'consultas' => $consultas], 200);

        /*foreach ($consultas as $key => $value) {
            echo "{$value->id_doctor} {$value->especialidad} {$value->paciente} \n";
        }*/
    }
    public function listConsulta(Request $req){
        $doctor = $req->input('doctor');
        $doctor = intval($doctor);
        try {
            $consultas = DB::table('consultas')->where('id_doctor',$doctor)->get()->toArray();
            $bonos = DB::table('bonos')->where('id_doctor',$doctor)->get()->toArray();
            //$response['data']=$data;
            //$response['message']='Load successfull';
            //$response['success']= true;
        } catch (\Exception $e) {
            //$response['message']=$e->getMessage();
            //$response['success']= false;
        }

        $data = array_merge($consultas, $bonos);
        
        function object_sorter($clave,$orden=null) {
            return function ($a, $b) use ($clave,$orden) {
                  $result=  ($orden=="DESC") ? strnatcmp($b->$clave, $a->$clave) :  strnatcmp($a->$clave, $b->$clave);
                  return $result;
            };
        }
        usort($data, object_sorter('fecha_atencion'));

        //print_r($data);
        return json_encode($data);
        //return response()->json(['success' => true, 'consultas' => $consultas], 200);
    }

    public function listConsultaFiltros(Request $req){
        $tipoPaciente = $req->input('tipoPac');
        $tipoConsulta = $req->input('tipoCons');
        $tipoEstado = $req->input('tipoEst');
        $finicio = $req->input('finicio');
        $ffin = $req->input('ffin');
        $doctor = $req->input('doctor');
        $doctor = intval($doctor);

        try {
            if(!empty($tipoPaciente) && !empty($tipoConsulta) && !empty($tipoEstado) && !empty($finicio) && !empty($ffin)){
                $data = DB::table('consultas')
                        ->where('id_doctor',$doctor)
                        ->where('tipo_paciente',$tipoPaciente)
                        ->where('tipo_atencion',$tipoConsulta)
                        ->where('estado',$tipoEstado)
                        ->whereBetween('fecha_atencion', [$finicio, $ffin])->get()->toArray();

            }else if(!empty($tipoPaciente) && !empty($tipoConsulta) && !empty($tipoEstado)){//abc
                $data = DB::table('consultas')
                        ->where('id_doctor',$doctor)
                        ->where('tipo_paciente',$tipoPaciente)
                        ->where('tipo_atencion',$tipoConsulta)
                        ->where('estado',$tipoEstado)->get()->toArray();

            }else if(!empty($tipoPaciente) && !empty($tipoConsulta) && !empty($finicio) && !empty($ffin)){//abd
                $data = DB::table('consultas')
                        ->where('id_doctor',$doctor)
                        ->where('tipo_paciente',$tipoPaciente)
                        ->where('tipo_atencion',$tipoConsulta)
                        ->whereBetween('fecha_atencion', [$finicio, $ffin])->get()->toArray();

            }else if(!empty($tipoPaciente) && !empty($tipoEstado) && !empty($finicio) && !empty($ffin)){//acd
                $data = DB::table('consultas')
                        ->where('id_doctor',$doctor)
                        ->where('tipo_paciente',$tipoPaciente)
                        ->where('estado',$tipoEstado)
                        ->whereBetween('fecha_atencion', [$finicio, $ffin])->get()->toArray();
            
            }else if(!empty($tipoConsulta) && !empty($tipoEstado) && !empty($finicio) && !empty($ffin)){//bcd
                $data = DB::table('consultas')
                        ->where('id_doctor',$doctor)
                        ->where('tipo_atencion',$tipoConsulta)
                        ->where('estado',$tipoEstado)
                        ->whereBetween('fecha_atencion', [$finicio, $ffin])->get()->toArray();
            
            }else if(!empty($tipoPaciente) && !empty($tipoConsulta)){//ab
                $data = DB::table('consultas')
                        ->where('id_doctor',$doctor)
                        ->where('tipo_paciente',$tipoPaciente)
                        ->where('tipo_atencion',$tipoConsulta)->get()->toArray();
            
            }else if(!empty($tipoPaciente) && !empty($tipoEstado)){//ac
                $data = DB::table('consultas')
                        ->where('id_doctor',$doctor)
                        ->where('tipo_paciente',$tipoPaciente)
                        ->where('estado',$tipoEstado)->get()->toArray();
            
            }else if(!empty($tipoPaciente) && !empty($finicio) && !empty($ffin)){//ad
                $data = DB::table('consultas')
                        ->where('id_doctor',$doctor)
                        ->where('tipo_paciente',$tipoPaciente)
                        ->whereBetween('fecha_atencion', [$finicio, $ffin])->get()->toArray();

            }else if(!empty($tipoConsulta) && !empty($tipoEstado)){//bc
                $data = DB::table('consultas')
                        ->where('id_doctor',$doctor)
                        ->where('tipo_atencion',$tipoConsulta)
                        ->where('estado',$tipoEstado)->get()->toArray();

            }else if(!empty($tipoConsulta) && !empty($finicio) && !empty($ffin)){//bd
                $data = DB::table('consultas')
                        ->where('id_doctor',$doctor)
                        ->where('tipo_atencion',$tipoConsulta)
                        ->whereBetween('fecha_atencion', [$finicio, $ffin])->get()->toArray();

            }else if(!empty($tipoEstado) && !empty($finicio) && !empty($ffin)){//cd
                $data = DB::table('consultas')
                        ->where('id_doctor',$doctor)
                        ->where('estado',$tipoEstado)
                        ->whereBetween('fecha_atencion', [$finicio, $ffin])->get()->toArray();

            }else if(!empty($tipoPaciente)){//a
                $data = DB::table('consultas')
                        ->where('id_doctor',$doctor)
                        ->where('tipo_paciente',$tipoPaciente)->get()->toArray();

            }else if(!empty($tipoConsulta)){//b
                $data = DB::table('consultas')
                        ->where('id_doctor',$doctor)
                        ->where('tipo_atencion',$tipoConsulta)->get()->toArray();
            
            }else if(!empty($tipoEstado)){//c
                $data = DB::table('consultas')
                        ->where('id_doctor',$doctor)
                        ->where('estado',$tipoEstado)->get()->toArray();

            }else if(!empty($finicio) && !empty($ffin)){//d
                $data = DB::table('consultas')
                        ->where('id_doctor',$doctor)
                        ->whereBetween('fecha_atencion', [$finicio, $ffin])->get()->toArray();
            }else{
                $data = DB::table('consultas')
                        ->where('id_doctor',$doctor)->get()->toArray();
            }

            $doctor = DB::table('doctores')->where('id_doctor',$doctor)->get();
        } catch (\Exception $e) {
            //$response['message']=$e->getMessage();
            //$response['success']= false;
        }


        foreach ($data as $key => $value) {
            $value->id = $key;
            //$value->nom_doctor = $doctor[0]->nombres ." ". $doctor[0]->ap_pat ." ". $doctor[0]->ap_mat;
            $value->nom_doctor = $doctor[0]->APELLIDOS_NOMBRES;
        }
        return json_encode($data);
    }
    public function registroFactura(Request $req){
        $ruc =  $req->input('ruc');
        $concepto = $req->input('concepto');
        $clavesol = $req->input('clavesol');
        $pass = $req->input('pass');
        $monto = $req->input('monto');
        $monto = floatval($monto);

        try {
            $id = DB::table('facturas')->insertGetId([
                'ruc' => $ruc,
                'concepto' => $concepto,
                'fec_emision'=> date('Y-m-d'),
                'monto' => $monto
            ]);

            $fact = DB::table('facturas')->where('id',$id)->first();
        } catch (\Exception $e) {
            
        }

        echo json_encode($fact);
    }

    public function listMontos(Request $req){
        //$rubro = $req->input('rubro');
        $doctor = $req->input('doctor');
        $doctor = intval($doctor);

        try {
            $cantidades[0] = DB::table('consultas')
                    ->where('id_doctor',$doctor)
                    ->where('estado','pendiente')
                    ->where('tipo_atencion','cita')
                    ->where('tipo_paciente','seguro')->count();

            $cantidades[1] = DB::table('consultas')
                    ->where('id_doctor',$doctor)
                    ->where('estado','pendiente')
                    ->where('tipo_atencion','cita')
                    ->where('tipo_paciente','particular')->count();
            
            $cantidades[2] = DB::table('consultas')
                    ->where('id_doctor',$doctor)
                    ->where('estado','pendiente')
                    ->where('tipo_atencion','procedimiento')
                    ->where('tipo_paciente','seguro')->count();

            $cantidades[3] = DB::table('consultas')
                    ->where('id_doctor',$doctor)
                    ->where('estado','pendiente')
                    ->where('tipo_atencion','procedimiento')
                    ->where('tipo_paciente','particular')->count();
            
            $cantidades[4] = DB::table('bonos')
                    ->where('id_doctor',$doctor)
                    ->where('estado','pendiente')
                    ->where('tipo_paciente','seguro')->count();
                
            $cantidades[5] = DB::table('bonos')
                    ->where('id_doctor',$doctor)
                    ->where('estado','pendiente')
                    ->where('tipo_paciente','particular')->count();

            $montos[0] = DB::table('consultas')
                    ->where('id_doctor',$doctor)
                    ->where('estado','pendiente')
                    ->where('tipo_atencion','cita')
                    ->where('tipo_paciente','seguro')->sum('importe_total');

            $montos[1] = DB::table('consultas')
                    ->where('id_doctor',$doctor)
                    ->where('estado','pendiente')
                    ->where('tipo_atencion','cita')
                    ->where('tipo_paciente','particular')->sum('importe_total');

            $montos[2] = DB::table('consultas')
                    ->where('id_doctor',$doctor)
                    ->where('estado','pendiente')
                    ->where('tipo_atencion','procedimiento')
                    ->where('tipo_paciente','seguro')->sum('importe_total');

            $montos[3] = DB::table('consultas')
                    ->where('id_doctor',$doctor)
                    ->where('estado','pendiente')
                    ->where('tipo_atencion','procedimiento')
                    ->where('tipo_paciente','particular')->sum('importe_total');
            
            $montos[4] = DB::table('bonos')
                    ->where('id_doctor',$doctor)
                    ->where('estado','pendiente')
                    ->where('tipo_paciente','seguro')->sum('monto');
            
            $montos[5] = DB::table('bonos')
                    ->where('id_doctor',$doctor)
                    ->where('estado','pendiente')
                    ->where('tipo_paciente','particular')->sum('monto');
            //echo($cita);

        } catch (\Exception $e) {
            //echo e;
        }
        //echo(gettype($cita));
        $totales[0] = $montos[0] + $montos[1];
        $totales[1] = $montos[2] + $montos[3];
        $totales[2] = $montos[4] + $montos[5];

        $total = array_sum($totales);
        /*print_r($cantidades);
        echo "\n";
        print_r($montos);
        echo "\n";
        print_r($totales);*/

        return response()->json(['success' => true,
                                'cantidades' => $cantidades,
                                'montos' => $montos,
                                'totales' => $totales,
                                'total' => $total],
                                200);
        //return json_encode($cantidades);
        //return json_encode($data);
    }

    public function listFacturas(Request $req){
        //$rubro = $req->input('rubro');
        $ruc = $req->input('ruc');
        $ruc = intval($ruc);
        try {
            $data = DB::table('facturas')
                    ->where('ruc',$ruc)->get()->toArray();

        } catch (\Exception $e) {

        }
        //echo(gettype($cita));
        //return json_encode($cantidades);
        return json_encode($data);
    }
}
