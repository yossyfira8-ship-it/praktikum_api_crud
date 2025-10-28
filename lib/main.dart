// lib/main.dart
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'user_model.dart';
import 'edit_user_page.dart';
import 'add_user_page.dart';
import 'user_list_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum API CRUD',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const UserListPage(),
    );
  }
}

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});
  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final ApiService apiService = ApiService();
  List<User> _users = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _refreshUserList();
  }

  Future<void> _refreshUserList() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final users = await apiService.fetchUsers();
      if (!mounted) return;
      setState(() {
        _users = users;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Gagal memuat data: $e';
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleDelete(User user) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: Text('Apakah Anda yakin ingin menghapus ${user.firstName}?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Batal')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    final id = user.id.toString();
    try {
      await apiService.deleteUser(id);
      // simulasi lokal: hapus dari list agar UI responsif
      setState(() => _users.removeWhere((u) => u.id == user.id));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User ${user.firstName} berhasil dihapus')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus user: $e')),
      );
    }
  }

  Future<void> _handleEdit(User user) async {
    final result = await Navigator.of(context).push<bool?>(
      MaterialPageRoute(builder: (_) => EditUserPage(user: user)),
    );
    if (result == true) {
      // refresh list after successful update
      await _refreshUserList();
    }
  }

  Future<void> _handleAdd() async {
    final result = await Navigator.of(context).push<bool?>(
      MaterialPageRoute(builder: (_) => const AddUserPage()),
    );
    if (result == true) {
      await _refreshUserList();
    }
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_error!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _refreshUserList, child: const Text('Coba Lagi')),
          ],
        ),
      );
    }
    if (_users.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Tidak ada user', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _refreshUserList, child: const Text('Refresh')),
          ],
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: _refreshUserList,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return UserListItem(
            user: user,
            onEdit: () => _handleEdit(user),
            onDelete: () => _handleDelete(user),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        centerTitle: true,
        elevation: 2,
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _handleAdd,
        icon: const Icon(Icons.add),
        label: const Text('Tambah User'),
      ),
    );
  }
}
