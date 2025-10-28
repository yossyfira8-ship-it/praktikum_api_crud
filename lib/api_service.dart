import 'dart:convert'; // Untuk jsonDecode
import 'package:http/http.dart' as http; // package http
import 'user_model.dart'; // model User
import 'created_user_model.dart'; // model response create/update

class ApiService {
  final String baseUrl = 'https://reqres.in/api';

  // READ (GET): Mengambil daftar pengguna dari API
  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users?page=2'));

    if (response.statusCode == 200) {
      // Jika server mengembalikan status code 200 OK, parse JSON.
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> userListJson = data['data'];

      // Ubah setiap item JSON menjadi objek User
      return userListJson
          .map((json) => User.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      // Jika respon bukan 200 OK, lempar exception.
      throw Exception('Failed to load users: ${response.statusCode}');
    }
  }

  // CREATE (POST): Membuat user baru
  Future<CreatedUser> createUser(String name, String job) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'job': job,
      }),
    );

    if (response.statusCode == 201) {
      // 201 Created
      return CreatedUser.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to create user: ${response.statusCode}');
    }
  }

  // UPDATE (PUT): Memperbarui user berdasarkan ID
  Future<CreatedUser> updateUser(String id, String name, String job) async {
    if (id.isEmpty) throw Exception('ID nggak boleh kosong');
    final response = await http.put(
      Uri.parse('$baseUrl/users/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'job': job,
      }),
    );

    if (response.statusCode == 200) {
      // 200 OK
      return CreatedUser.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to update user: ${response.statusCode}');
    }
  }

  // DELETE: Menghapus user berdasarkan ID
  Future<void> deleteUser(String id) async {
    if (id.isEmpty) throw Exception('ID nggak boleh kosong');
    final response = await http.delete(
      Uri.parse('$baseUrl/users/$id'),
    );

    if (response.statusCode != 204) {
      // 204 No Content = Berhasil dihapus tanpa body
      throw Exception('Failed to delete user: ${response.statusCode}');
    }
  }
}