<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\ExcelController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});


Route::post('/login',[UserController::class,'login']);
Route::post('/logout',[UserController::class,'logout']);
Route::post('/getcode',[UserController::class,'getCode']);
Route::post('/registrar',[UserController::class,'registrar']);
Route::post('/actruc',[UserController::class,'actruc']);
Route::get('/listar',[UserController::class,'listConsulta']);
Route::get('/filtros',[UserController::class,'listConsultaFiltros']);
Route::post('/registrofact',[UserController::class,'registroFactura']);
Route::get('/montos',[UserController::class,'listMontos']);
Route::get('/facturas',[UserController::class,'listFacturas']);

Route::get('/cargarexcel',[ExcelController::class,'cargarExcel']);