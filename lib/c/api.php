<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
Route::group(['namespace' => 'Api', 'prefix' => 'v1'], function () {
    Route::post('login', [\App\Http\Controllers\Api\AuthenticationController::class, 'login']);
    Route::post('logout', [\App\Http\Controllers\Api\AuthenticationController::class, 'destroy'])->middleware('auth:api');
    Route::post('register', [\App\Http\Controllers\Api\AuthenticationController::class, 'saveNewUser']);
    Route::post('updateprofile', [\App\Http\Controllers\Api\ProfileController::class, 'updateProfile'])->middleware('auth:api');
    Route::get('getproductlist', [\App\Http\Controllers\Api\ProductController::class, 'getAllProductList'])->middleware('auth:api');
    Route::get('getallcat', [\App\Http\Controllers\Api\ProductController::class, 'getAllCat'])->middleware('auth:api');
    Route::get('getproductcat', [\App\Http\Controllers\Api\ProductController::class, 'getProductCat'])->middleware('auth:api');
    Route::middleware('auth:api')->group(function () {
        Route::post('/messages/send', [\App\Http\Controllers\Api\MessageController::class, 'sendMessage']);
        Route::get('/messages/{user_id}', [\App\Http\Controllers\Api\MessageController::class, 'getMessages']);
        Route::delete('/delete/{id}', [\App\Http\Controllers\Api\MessageController::class, 'deleteMessage']);
        Route::get('/users', [\App\Http\Controllers\Api\UserController::class, 'index']);
        Route::get('/users/search', [\App\Http\Controllers\Api\UserController::class, 'search']);
    });
    Route::group(['middleware' => 'auth:api'], function () {
        Route::get('/courses', [\App\Http\Controllers\Api\LearningController::class, 'getMyKhoaHoc']);
        Route::post('/upload-lesson', [\App\Http\Controllers\Api\LearningController::class, 'uploadLesson']);
        Route::get('/lesson-content/{baiHocId}', [\App\Http\Controllers\Api\LearningController::class, 'getLessonContent']);
        Route::post('/create-course', [\App\Http\Controllers\Api\LearningController::class, 'createKhoaHoc']);
        Route::get('/lessons/{khoaHocId}', [\App\Http\Controllers\Api\LearningController::class, 'getLessons']);
        Route::get('/lesson/{baiHocId}', [\App\Http\Controllers\Api\LearningController::class, 'getLessonDetail']);
        Route::get('/learning-progress/{khoaHocId}', [\App\Http\Controllers\Api\LearningController::class, 'getLearningProgress']);
        Route::delete('/delete-course/{khoaHocId}', [\App\Http\Controllers\Api\LearningController::class, 'deleteKhoaHoc']);
        Route::delete('/delete-lesson/{baiHocId}', [\App\Http\Controllers\Api\LearningController::class, 'deleteBaiHoc']);
    });
    // Route::get('khoahoc', [\App\Http\Controllers\Api\ApiKhoahocController::class, 'index']);  // GET: Lấy danh sách khóa học
    // Route::get('baihoc', [\App\Http\Controllers\Api\ApiBaihocController::class, 'index']);  // GET: Lấy danh sách khóa học
    Route::group(['middleware' => 'auth:api'], function () {
        Route::get('/credit-cards', [\App\Http\Controllers\Api\CreditCardController::class, 'index']);
        Route::post('/credit-cards', [\App\Http\Controllers\Api\CreditCardController::class, 'store']);
        Route::post('/credit-cards/{id}/set-default', [\App\Http\Controllers\Api\CreditCardController::class, 'setDefault']);
        Route::delete('/credit-cards/{id}', [\App\Http\Controllers\Api\CreditCardController::class, 'destroy']);
    });
    
  });
  use App\Http\Controllers\Api\ApiLecturerController;

  Route::prefix('v1')->group(function () {
      // Route lấy tất cả giảng viên
      Route::get('lecturers', [APILecturerController::class, 'index']);
      
      // Route lấy giảng viên theo ID
      Route::get('lecturers/{id}', [APILecturerController::class, 'show']);
  });