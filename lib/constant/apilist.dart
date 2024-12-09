import '../models/profile.dart';

final String base = 'http://127.0.0.1:8000/api/v1';

// Authentication & Profile
final String api_register = '$base/register';
final String api_login = '$base/login';
final String api_updateprofile = '$base/updateprofile';

// Messages
final String api_send_message = '$base/messages/send';
final String api_get_messages = '$base/messages';
final String api_delete_message = '$base/delete'; // Cập nhật theo route mới
final String api_search_users = '$base/users/search';

// Products
final String api_ge_product_list = '$base/getproductcat';

// Learning/Courses
final String api_get_courses = '$base/courses';
final String api_assign_course = '$base/assign-course';
final String api_upload_lesson = '$base/upload-lesson';
final String api_get_lessons = '$base/lessons';
final String api_get_lesson_detail = '$base/lesson';
final String api_create_course = '$base/create-course';
final String api_get_lesson_content = '$base/lesson-content';
final String api_get_learning_progress = '$base/learning-progress';
final String api_delete_course = '$base/delete-course';
final String api_delete_lesson = '$base/delete-lesson';
final String api_save_course = '$base/save-course';
final String api_get_saved_courses = '$base/saved-courses';
final String api_search_courses = '$base/search-courses';

// Feedback APIs
final String api_feedbacks = '$base/feedbacks';
final String api_feedback_status = '$base/feedbacks'; // Base URL cho update status và delete

// Credit Card APIs
final String api_credit_cards = '$base/credit-cards';
final String api_credit_cards_set_default = '$base/credit-cards'; // + /{id}/set-default
final String api_credit_cards_delete = '$base/credit-cards'; // + /{id}

// Global Variables
String token = '';
Profile initialProfile = Profile(
    full_name: 'md',
    phone: '',
    address: '',
    photo: 'assets/default_avatar.png',
    email: ''
);
