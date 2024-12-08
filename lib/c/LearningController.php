<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\BaiHoc;
use App\Models\KhoaHoc;
use App\Models\User;
use App\Models\UserKhoaHoc;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class LearningController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api');
    }

    /**
     * Lấy danh sách khóa học đã mua/được cấp quyền
     */
    public function getMyKhoaHoc()
    {
        try {
            $khoaHocs = KhoaHoc::where('trang_thai', 'active')
                ->get()
                ->map(function ($khoaHoc) {
                    // Debug: In ra đường dẫn gốc của thumbnail
                    Log::info('Original thumbnail path: ' . $khoaHoc->thumbnail);
                    
                    $thumbnailUrl = null;
                    if ($khoaHoc->thumbnail) {
                        // Kiểm tra file có tồn tại không
                        if (Storage::disk('public')->exists($khoaHoc->thumbnail)) {
                            $thumbnailUrl = asset('storage/' . $khoaHoc->thumbnail);
                            Log::info('Generated thumbnail URL: ' . $thumbnailUrl);
                        } else {
                            Log::error('Thumbnail file not found: ' . $khoaHoc->thumbnail);
                        }
                    }

                    return [
                        'id' => $khoaHoc->id,
                        'ten_khoa_hoc' => $khoaHoc->ten_khoa_hoc,
                        'mo_ta' => $khoaHoc->mo_ta,
                        'gia' => $khoaHoc->gia,
                        'thumbnail' => $thumbnailUrl,
                        'trang_thai' => $khoaHoc->trang_thai,
                        'created_by' => $khoaHoc->created_by,
                        'created_at' => $khoaHoc->created_at,
                        'updated_at' => $khoaHoc->updated_at,
                    ];
                });

            return response()->json([
                'status' => true,
                'data' => $khoaHocs
            ], 200);
        } catch (\Exception $e) {
            Log::error('Error in getMyKhoaHoc: ' . $e->getMessage());
            return response()->json([
                'status' => false,
                'message' => 'Có lỗi xảy ra',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Lấy nội dung bài học (video/văn bản)
     */
    public function getLessonContent($khoaHocId)
    {
        try {
            // Lấy danh sách bài học theo khóa học
            $baiHocs = BaiHoc::where('id_khoahoc', $khoaHocId)
                ->orderBy('thu_tu', 'asc')
                ->get()
                ->map(function ($baiHoc) {
                    $videoUrl = $baiHoc->video ? url('storage/' . $baiHoc->video) : null;
                    
                    return [
                        'id' => $baiHoc->id,
                        'tenBaiHoc' => $baiHoc->ten_bai_hoc,
                        'moTa' => $baiHoc->mo_ta,
                        'idKhoahoc' => $baiHoc->id_khoahoc,
                        'video' => $videoUrl,
                        'noiDung' => $baiHoc->noi_dung,
                        'taiLieu' => $baiHoc->tai_lieu ? json_decode($baiHoc->tai_lieu) : [],
                        'thuTu' => $baiHoc->thu_tu,
                        'thoiLuong' => $baiHoc->thoi_luong,
                        'trangThai' => $baiHoc->trang_thai,
                        'luotXem' => $baiHoc->luot_xem,
                        'createdAt' => $baiHoc->created_at,
                        'updatedAt' => $baiHoc->updated_at
                    ];
                });

            if ($baiHocs->isEmpty()) {
                return response()->json([
                    'status' => false,
                    'message' => 'Không tìm thấy bài học nào'
                ], 404);
            }

            // Cập nhật lượt xem
            BaiHoc::where('id_khoahoc', $khoaHocId)->increment('luot_xem');

            return response()->json([
                'status' => true,
                'data' => $baiHocs
            ], 200);

        } catch (\Exception $e) {
            Log::error('Error in getLessonContent: ' . $e->getMessage());
            return response()->json([
                'status' => false,
                'message' => 'Có lỗi xảy ra',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Upload nội dung bài học mới
     */
    public function uploadLesson(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'ten_bai_hoc' => 'required|string',
                'mo_ta' => 'nullable|string',
                'id_khoahoc' => 'required|exists:khoa_hocs,id',
                'video' => 'nullable|mimes:mp4,mov,avi|max:204800',
                'noi_dung' => 'nullable|string',
                'tai_lieu.*' => 'nullable|mimes:pdf,doc,docx|max:10240',
                'thu_tu' => 'required|integer',
                'thoi_luong' => 'nullable|integer'
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'status' => false,
                    'errors' => $validator->errors()
                ], 422);
            }

            // Upload video nếu có
            $videoPath = null;
            if ($request->hasFile('video')) {
                $videoPath = $request->file('video')->store('lessons/videos', 'public');
                // Tạo URL đầy đủ cho video
                $videoUrl = url('storage/' . $videoPath);
            }

            // Upload tài liệu đính kèm nếu có
            $attachments = [];
            if ($request->hasFile('tai_lieu')) {
                foreach ($request->file('tai_lieu') as $file) {
                    $path = $file->store('lessons/attachments', 'public');
                    $attachments[] = [
                        'name' => $file->getClientOriginalName(),
                        'path' => $path
                    ];
                }
            }

            // Tạo bài học mới với đầy đủ thông tin
            $baiHoc = BaiHoc::create([
                'ten_bai_hoc' => $request->ten_bai_hoc,
                'mo_ta' => $request->mo_ta,
                'id_khoahoc' => $request->id_khoahoc,
                'video' => $videoPath,
                'noi_dung' => $request->noi_dung,
                'tai_lieu' => json_encode($attachments),
                'thu_tu' => $request->thu_tu ?? 0,
                'thoi_luong' => $request->thoi_luong,
                'trang_thai' => 'active'
            ]);

            // Trả về response với URL đầy đủ
            return response()->json([
                'status' => true,
                'message' => 'Tạo bài học thành công',
                'data' => array_merge($baiHoc->toArray(), [
                    'video_url' => $videoPath ? url('storage/' . $videoPath) : null
                ])
            ], 201);

        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => 'Có lỗi xảy ra',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Lấy danh sách bài học của khóa học
     */
    public function getLessons($khoaHocId)
    {
        try {
            $khoaHoc = KhoaHoc::find($khoaHocId);
            if (!$khoaHoc) {
                return response()->json([
                    'status' => false,
                    'message' => 'Không tìm thấy khóa học'
                ], 404);
            }

            $baiHocs = BaiHoc::where('id_khoahoc', $khoaHocId)
                ->orderBy('thu_tu', 'asc')
                ->get();

            return response()->json([
                'status' => true,
                'data' => [
                    'khoa_hoc' => $khoaHoc,
                    'bai_hocs' => $baiHocs
                ]
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => 'Có lỗi xảy ra',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Lấy chi tiết một bài học
     */
    public function getLessonDetail($baiHocId)
    {
        try {
            $baiHoc = BaiHoc::with('khoaHoc')->find($baiHocId);

            if (!$baiHoc) {
                return response()->json([
                    'status' => false,
                    'message' => 'Không tìm thấy bài học'
                ], 404);
            }

            // Cập nhật tiến độ học tập
            $this->updateLearningProgress(Auth::id(), $baiHocId);

            return response()->json([
                'status' => true,
                'data' => $baiHoc
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => 'Có lỗi xảy ra',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Cập nhật tiến độ học tập
     */
    private function updateLearningProgress($userId, $baiHocId)
    {
        try {
            DB::table('learning_progress')->updateOrInsert(
                [
                    'user_id' => $userId,
                    'bai_hoc_id' => $baiHocId
                ],
                [
                    'completed' => true,
                    'completed_at' => now()
                ]
            );
        } catch (\Exception $e) {
            Log::error('Lỗi cập nhật tiến độ học tập: ' . $e->getMessage());
        }
    }

    /**
     * Lấy tiến độ học tập của user
     */
    public function getLearningProgress($khoaHocId)
    {
        try {
            $progress = DB::table('learning_progress as lp')
                ->join('bai_hocs as bh', 'lp.bai_hoc_id', '=', 'bh.id')
                ->where('lp.user_id', Auth::id())
                ->where('bh.id_khoahoc', $khoaHocId)
                ->select('bh.id', 'bh.ten_bai_hoc', 'lp.completed', 'lp.completed_at')
                ->get();

            return response()->json([
                'status' => true,
                'data' => $progress
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => 'Có lỗi xảy ra',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Tạo khóa học mới
     */
    public function createKhoaHoc(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'ten_khoa_hoc' => 'required|string|max:255',
                'mo_ta' => 'nullable|string',
                'gia' => 'required|numeric',
                'thumbnail' => 'nullable|image|max:2048', // 2MB max
                'trang_thai' => 'required|in:active,inactive'
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'status' => false,
                    'errors' => $validator->errors()
                ], 422);
            }

            // Upload thumbnail nếu có
            $thumbnailPath = null;
            if ($request->hasFile('thumbnail')) {
                $thumbnailPath = $request->file('thumbnail')->store('khoa_hoc/thumbnails', 'public');
            }

            // Tạo khóa học mới
            $khoaHoc = KhoaHoc::create([
                'ten_khoa_hoc' => $request->ten_khoa_hoc,
                'mo_ta' => $request->mo_ta,
                'gia' => $request->gia,
                'thumbnail' => $thumbnailPath,
                'trang_thai' => $request->trang_thai,
                'created_by' => Auth::id()
            ]);

            // Trả về response với URL đầy đủ cho thumbnail
            return response()->json([
                'status' => true,
                'message' => 'Tạo khóa học thành công',
                'data' => array_merge($khoaHoc->toArray(), [
                    'thumbnail' => $thumbnailPath ? url('storage/' . $thumbnailPath) : null
                ])
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => 'Có lỗi xảy ra',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Xóa khóa học
     */
    public function deleteKhoaHoc($khoaHocId)
    {
        try {
            $khoaHoc = KhoaHoc::where('id', $khoaHocId)
                              ->where('created_by', Auth::id()) // Chỉ người tạo mới được xóa
                              ->first();

            if (!$khoaHoc) {
                return response()->json([
                    'status' => false,
                    'message' => 'Không tìm thấy khóa học hoặc bạn không có quyền xóa'
                ], 404);
            }

            // Xóa các bài học liên quan
            BaiHoc::where('id_khoahoc', $khoaHocId)->delete();

            // Xóa các file liên quan
            if ($khoaHoc->thumbnail) {
                Storage::disk('public')->delete($khoaHoc->thumbnail);
            }
            if ($khoaHoc->image) {
                Storage::disk('public')->delete($khoaHoc->image);
            }

            // Xóa khóa học
            $khoaHoc->delete();

            return response()->json([
                'status' => true,
                'message' => 'Xóa khóa học thành công'
            ], 200);

        } catch (\Exception $e) {
            Log::error('Error in deleteKhoaHoc: ' . $e->getMessage());
            return response()->json([
                'status' => false,
                'message' => 'Có lỗi xảy ra khi xóa khóa học',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Xóa bài học
     */
    public function deleteBaiHoc($baiHocId)
    {
        try {
            $baiHoc = BaiHoc::with('khoaHoc')->find($baiHocId);

            if (!$baiHoc) {
                return response()->json([
                    'status' => false,
                    'message' => 'Không tìm thấy bài học'
                ], 404);
            }

            // Kiểm tra quyền xóa (chỉ người tạo khóa học mới được xóa bài học)
            if ($baiHoc->khoaHoc->created_by !== Auth::id()) {
                return response()->json([
                    'status' => false,
                    'message' => 'Bạn không có quyền xóa bài học này'
                ], 403);
            }

            // Xóa các file liên quan
            if ($baiHoc->video) {
                Storage::disk('public')->delete($baiHoc->video);
            }

            // Xóa tài liệu đính kèm
            if ($baiHoc->tai_lieu) {
                $taiLieu = json_decode($baiHoc->tai_lieu, true);
                foreach ($taiLieu as $file) {
                    if (isset($file['path'])) {
                        Storage::disk('public')->delete($file['path']);
                    }
                }
            }

            // Xóa bài học
            $baiHoc->delete();

            return response()->json([
                'status' => true,
                'message' => 'Xóa bài học thành công'
            ], 200);

        } catch (\Exception $e) {
            Log::error('Error in deleteBaiHoc: ' . $e->getMessage());
            return response()->json([
                'status' => false,
                'message' => 'Có lỗi xảy ra khi xóa bài học',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Lưu khóa học yêu thích
     */
    public function saveKhoaHoc($khoaHocId)
    {
        try {
            // Kiểm tra khóa học tồn tại
            $khoaHoc = KhoaHoc::find($khoaHocId);
            if (!$khoaHoc) {
                return response()->json([
                    'status' => false,
                    'message' => 'Không tìm thấy khóa học'
                ], 404);
            }

            // Kiểm tra xem đã lưu chưa
            $exists = DB::table('saved_courses')
                ->where('user_id', Auth::id())
                ->where('khoa_hoc_id', $khoaHocId)
                ->exists();

            if ($exists) {
                // Nếu đã lưu thì xóa (unlike)
                DB::table('saved_courses')
                    ->where('user_id', Auth::id())
                    ->where('khoa_hoc_id', $khoaHocId)
                    ->delete();

                return response()->json([
                    'status' => true,
                    'message' => 'Đã bỏ lưu khóa học',
                    'is_saved' => false
                ], 200);
            } else {
                // Nếu chưa lưu thì thêm mới (like)
                DB::table('saved_courses')->insert([
                    'user_id' => Auth::id(),
                    'khoa_hoc_id' => $khoaHocId,
                    'created_at' => now(),
                    'updated_at' => now()
                ]);

                return response()->json([
                    'status' => true,
                    'message' => 'Đã lưu khóa học',
                    'is_saved' => true
                ], 200);
            }

        } catch (\Exception $e) {
            Log::error('Error in saveKhoaHoc: ' . $e->getMessage());
            return response()->json([
                'status' => false,
                'message' => 'Có lỗi xảy ra',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Lấy danh sách khóa học đã lưu
     */
    public function getSavedKhoaHoc()
    {
        try {
            $savedCourses = DB::table('saved_courses as sc')
                ->join('khoa_hocs as kh', 'sc.khoa_hoc_id', '=', 'kh.id')
                ->where('sc.user_id', Auth::id())
                ->where('kh.trang_thai', 'active')
                ->select('kh.*', 'sc.created_at as saved_at')
                ->orderBy('sc.created_at', 'desc')
                ->get()
                ->map(function ($khoaHoc) {
                    $thumbnailUrl = null;
                    if ($khoaHoc->thumbnail) {
                        if (Storage::disk('public')->exists($khoaHoc->thumbnail)) {
                            $thumbnailUrl = asset('storage/' . $khoaHoc->thumbnail);
                        }
                    }

                    return [
                        'id' => $khoaHoc->id,
                        'ten_khoa_hoc' => $khoaHoc->ten_khoa_hoc,
                        'mo_ta' => $khoaHoc->mo_ta,
                        'gia' => $khoaHoc->gia,
                        'thumbnail' => $thumbnailUrl,
                        'trang_thai' => $khoaHoc->trang_thai,
                        'created_by' => $khoaHoc->created_by,
                        'saved_at' => $khoaHoc->saved_at
                    ];
                });

            return response()->json([
                'status' => true,
                'data' => $savedCourses
            ], 200);

        } catch (\Exception $e) {
            Log::error('Error in getSavedKhoaHoc: ' . $e->getMessage());
            return response()->json([
                'status' => false,
                'message' => 'Có lỗi xảy ra',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
