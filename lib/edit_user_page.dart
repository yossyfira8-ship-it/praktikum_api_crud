import 'package:flutter/material.dart';
import 'api_service.dart';
import 'user_model.dart';

class EditUserPage extends StatefulWidget {
  final User user;
  const EditUserPage({Key? key, required this.user}) : super(key: key);

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  final ApiService apiService = ApiService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.user.firstName);
    lastNameController = TextEditingController(text: widget.user.lastName);
    emailController = TextEditingController(text: widget.user.email);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final String id = widget.user.id.toString();
    final String name = '${firstNameController.text.trim()} ${lastNameController.text.trim()}';
    final String job = emailController.text.trim(); // dipakai sebagai "job" sesuai ApiService

    try {
      await apiService.updateUser(id, name, job);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User berhasil diupdate')),
      );
      Navigator.of(context).pop(true); // kembalikan true agar list bisa di-refresh
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengupdate user: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String? _notEmptyValidator(String? value) {
    if (value == null || value.isEmpty) return 'Nggak boleh kosong';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit User')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // First name
              TextFormField(
                controller: firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: _notEmptyValidator,
              ),
              const SizedBox(height: 8),
              // Last name
              TextFormField(
                controller: lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: _notEmptyValidator,
              ),
              const SizedBox(height: 8),
              // Email (dipakai sebagai "job" pada reqres)
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: _notEmptyValidator,
              ),
              const SizedBox(height: 8),
              // Avatar (read-only) - reqres.in tidak mendukung update avatar
              TextFormField(
                initialValue: widget.user.avatar,
                decoration: const InputDecoration(
                  labelText: 'Avatar (tidak bisa diubah)',
                ),
                readOnly: true,
              ),
              const SizedBox(height: 6),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Catatan: reqres.in tidak mendukung update avatar, field ini hanya untuk informasi.',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isLoading ? null : _onSubmit,
                child: _isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Update User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}