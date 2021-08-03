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
           echo $user->nom_usuario;
        }
    }
}
