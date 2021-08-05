<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class UserController extends Controller{
    function login(Request $req){
        $username =  $req->input('userLogin');
        $password = $req->input('passLogin');
 
        $user = DB::table('usuarios')->where('nom_usuario',$username)->first();
        if($user->clave != $password){
            echo "Not Matched";
        }else{
            $doctor = DB::table('doctores')->where('id_doctor',$user->id_doctor)->get();
            echo json_encode($doctor[0]);
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
            $data = DB::table('consultas')->where('id_doctor',$doctor)->get()->toArray();
            //$response['data']=$data;
            //$response['message']='Load successfull';
            //$response['success']= true;
        } catch (\Exception $e) {
            //$response['message']=$e->getMessage();
            //$response['success']= false;
        }
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

            /*

            $data = DB::table('consultas')
                        ->where('id_doctor',$doctor)
                        ->where('tipo_paciente',$tipoPaciente)
                        ->where('tipo_estado',$tipoEstado)
                        ->where('tipo_atencion',$tipoConsulta)->get()->toArray();
            */
            
            //$data = DB::select("SELECT * FROM consultas WHERE tipo_paciente='$tipoPaciente' AND id_doctor='$doctor'" );
            //$response['data']=$data;
            //$response['message']='Load successfull';
            //$response['success']= true;
        } catch (\Exception $e) {
            //$response['message']=$e->getMessage();
            //$response['success']= false;
        }
        return json_encode($data);
    }
    public function registrar(Request $req){
        $ruc =  $req->input('ruc');
        $concepto = $req->input('concepto');
        $clavesol = $req->input('clavesol');
        $pass = $req->input('pass');

        DB::table('facturas')->insert([
            'ruc' => $ruc,
            'concepto' => $concepto,
            'fec_emision'=> CURRENT_TIMESTAMP,
            'monto'=>'5000',
        ]);
    }
}
