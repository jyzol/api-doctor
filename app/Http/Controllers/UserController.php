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

        echo json_encode($consultas);

        /*foreach ($consultas as $key => $value) {
            echo "{$value->id_doctor} {$value->especialidad} {$value->paciente} \n";
        }*/
    }
    public function listConsulta(Request $req){
        $doctor = $req->input('doctor');
        $doctor = intval($doctor);
        try {
            $data = DB::table('consultas')->where('id_doctor',$doctor)->get();
            //$response['data']=$data;
            //$response['message']='Load successfull';
            //$response['success']= true;
        } catch (\Exception $e) {
            //$response['message']=$e->getMessage();
            //$response['success']= false;
        }
        return $data;
    }
    public function listConsultaFiltros(Request $req){
        $tipoPaciente = $req->input('tipoPac');
        $doctor = $req->input('doctor');
        $doctor = intval($doctor);
        try {
            $data = DB::select("SELECT * FROM consultas WHERE tipo_paciente='$tipoPaciente' AND id_doctor='$doctor'" );
            //$response['data']=$data;
            //$response['message']='Load successfull';
            //$response['success']= true;
        } catch (\Exception $e) {
            //$response['message']=$e->getMessage();
            //$response['success']= false;
        }
        return $data;
    }
}
