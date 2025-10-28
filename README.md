# (CRUD & STYLING)
# Pengenalan Implementasi Dasar API Eksternal

NAMA: YOSSY FIRA ROSDIANA
NIM: 362458302022
KELAS : 2B TRPL

## Laporan Praktikum

## Tujuan Praktikum
1.	Memahami konsep dasar API (Application Programming Interface) dan REST API.
2.	Menggunakan package http di Flutter untuk melakukan permintaan (request) ke API eksternal.
3.	Melakukan operasi CRUD (Create, Read, Update, Delete) terhadap data melalui API.
4.	Mengurai data JSON (parsing) dan mengubahnya menjadi objek Dart (Model).
5.	Menampilkan data dari API ke dalam UI Flutter menggunakan widget seperti ListView.
6.	Mengimplementasikan styling dasar pada komponen UI untuk menyajikan data den gan rapi.
7.	Mengelola state secara sederhana untuk menangani data yang bersifat asinkron (asynchronous)

## Dasar Teori
3.1 Apa itu API?
API (Application Programming Interface) adalah seperangkat definisi, protokol, dan tools untuk membangun perangkat lunak aplikasi. Dalam praktikum ini, API bertin dak sebagai jembatan yang memungkinkan aplikasi Flutter (klien) Anda berkomunikasi dengan server (backend) untuk mengambil atau mengirim data.

3.2 REST API
REST (Representational State Transfer) adalah gaya arsitektur yang paling umum digunakan untuk membuat API berbasis web. REST API menggunakan metode HTTP standar untuk melakukan operasi pada resources.

3.3 JSON (JavaScript Object Notation)
JSON adalah format pertukaran data yang ringan dan mudah dibaca manusia serta di parsing oleh mesin. Hampir semua REST API menggunakan JSON sebagai format data utama.

3.4 Package http
Package http adalah library yang direkomendasikan untuk melakukan permintaan HTTP di Dart dan Flutter. Package ini menyediakan fungsi-fungsi mudah digunakan seperti http.get(), http.post(), http.put(), dan http.delete().

## Langkah Langkah Implementasi
4.1 Bagian 1 – Setup Proyek dan Penambahan Package http

* Langkah pertama adalah membuat proyek Flutter baru dengan perintah:
flutter create praktikum_api_crud
cd praktikum_api_crud

* Kemudian buka file pubspec.yaml dan tambahkan package:
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.1

* lalu jalankan flutter pub get

4.2 Bagian 2 – Membuat Model Data (User Model)

* Pada tahap ini dibuat file lib/user_model.dart untuk menampung struktur data pengguna sesuai respons dari API reqres.in. Model ini mempermudah proses parsing JSON ke bentuk objek Dart.

4.3 Bagian 3 – Membaca Data (READ - GET Request)

* Data pengguna diambil dari API menggunakan fungsi fetchUsers() dan ditampilkan dalam daftar menggunakan ListView.builder. Data yang diambil berupa avatar, nama, dan email pengguna.
  
  ![1](https://github.com/user-attachments/assets/48fd4152-c3ef-47d4-9fd7-570047dc860b)

  Menampilkan daftar pengguna dari API reqres.in.

4.4 Bagian 4 – Membuat Data (CREATE - POST Request)

* Form input digunakan untuk menambahkan data pengguna baru ke API. Form ini juga dilengkapi validasi agar data tidak kosong.

  ![2](https://github.com/user-attachments/assets/73f482cd-5eda-40b5-a529-b40dff157f2b)

  Form tambah user berhasil menampilkan input nama dan pekerjaan.

4.5.1 Implementasi UPDATE (PUT Request)

* Halaman edit user digunakan untuk memperbarui data yang sudah ada.

  ![3](https://github.com/user-attachments/assets/6aee8806-6f26-43b5-add3-cc6d16aadc2e)

  Tampilan halaman edit user yang digunakan untuk memperbarui nama atau pekerjaan.

4.5.2 Implementasi DELETE (DELETE Request)

* Tombol hapus memunculkan dialog konfirmasi sebelum data dihapus.

  ![4](https://github.com/user-attachments/assets/8d138af5-56ba-4fa2-8b01-bf4098838f34)

  Dialog konfirmasi hapus muncul sebelum data dihapus dari API.

## Analisis Kode
1. api_service.dart → Berisi semua fungsi komunikasi dengan API (fetchUsers, createUser, updateUser, deleteUser).
2. user_model.dart → Model data utama untuk parsing JSON dari API ke objek User.
3. created_user_model.dart → Model khusus untuk menyimpan hasil respons ketika menambah user (POST).
4. main.dart → File utama aplikasi. Menampilkan daftar user dari API menggunakan FutureBuilder, serta tombol tambah (+) untuk ke halaman add_user_page.
5. add_user_page.dart → Halaman form untuk menambah user baru.
6. edit_user_page.dart → Halaman untuk memperbarui (update) data user yang sudah ada.
7. user_list_item.dart → Komponen widget untuk menampilkan tiap item user di daftar (berisi avatar, nama, dan tombol edit/delete).

## Kesimpulan:
Aplikasi berhasil mengimplementasikan CRUD penuh (Create, Read, Update, Delete) menggunakan Flutter dan API ReqRes. Data dapat diambil, ditambahkan, diperbarui, dan dihapus dengan tampilan UI yang rapi dan validasi input yang berfungsi baik.

## Saran:
Gunakan state management seperti Provider, tambahkan fitur pencarian user, dan animasi transisi agar aplikasi lebih efisien dan menarik.
