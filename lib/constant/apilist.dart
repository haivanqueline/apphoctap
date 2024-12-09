import '../models/profile.dart';

// final String base = 'http://127.0.0.1:8000/api/v1';
// final String base = 'http://localhost:8000/api/v1';
final String base = 'http://127.0.0.1:8000/api/v1';
final String api_register =
    base + "/register"; // Thay bằng API thật localhost:8000/api/v1/register
final String api_updateprofile = base +
    "/updateprofile"; // Thay bằng API thật localhost:8000/api/v1/register
final String api_ge_product_list = base + "/getproductcat"; //
final String api_login = base + "/login";
String token = ''; //s
Profile initialProfile = Profile(
    full_name: 'md',
    phone: '',
    address: '',
    photo: '',
    email: 'default@email.com');
