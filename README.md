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
1. api_service.dart: Berisi semua fungsi komunikasi dengan API (fetchUsers, createUser, updateUser, deleteUser).
   Pengambilan Data (READ)
   
   <img width="1490" height="782" alt="carbon" src="https://github.com/user-attachments/assets/4abd0ccf-acd2-4769-87a6-ac31abf75fae" />

   fungsi inti buat membaca data dari API ReqRes dan mengubah hasil JSON jadi list User. Tanpa ini, aplikasi gak bisa menampilkan data apa pun di UI.

2. user_model.dart: Model data utama untuk parsing JSON dari API ke objek User.
   
4. created_user_model.dart: Model khusus untuk menyimpan hasil respons ketika menambah user (POST).
   
5. main.dart: File utama aplikasi. Menampilkan daftar user dari API menggunakan FutureBuilder, serta tombol tambah (+) untuk ke halaman add_user_page.

   Menampilkan Data di UI
   
   <img width="1354" height="1266" alt="carbon (1)" src="https://github.com/user-attachments/assets/c7a7e2f8-ab0b-4e3a-b8a7-71393252c723" />

   Menunjukkan hubungan antara data API dan tampilan Flutter (pakai FutureBuilder). Di sinilah data “hidup” dan muncul di layar.

   Menghapus Data (DELETE)
   
   <img width="1474" height="596" alt="carbon (4)" src="https://github.com/user-attachments/assets/c3660fae-b29e-44d3-b819-06904d3d26bd" />

   Bagian ini memperlihatkan bagaimana aplikasi menghapus data dari API dan memperbarui tampilan tanpa reload penuh.
   
6. add_user_page.dart: Halaman form untuk menambah user baru.
   Menambah Data (CREATE)
   
   <img width="1796" height="1192" alt="carbon (2)" src="https://github.com/user-attachments/assets/9f7af8d8-8b9c-45a4-811a-53652d7011fa" />

   Fungsi inti untuk mengirim data baru ke API (POST) dan memberikan feedback ke pengguna. Menunjukkan alur input → validasi → request → hasil.

7. edit_user_page.dart: Halaman untuk memperbarui (update) data user yang sudah ada.
    Memperbarui Data (UPDATE)
    
    <img width="1848" height="596" alt="carbon (3)" src="https://github.com/user-attachments/assets/e82df7ff-46a9-48ce-9982-555379838994" />

    Baris ini menunjukkan cara mengirim data hasil edit ke API (PUT), inti dari operasi Update dalam CRUD.

8. user_list_item.dart: Komponen widget untuk menampilkan tiap item user di daftar (berisi avatar, nama, dan tombol edit/delete).
    UI Komponen Tiap User

    <img width="1456" height="856" alt="carbon (5)" src="https://github.com/user-attachments/assets/7741f487-b9e7-4f2c-be89-15c12d9ca91c" />

    Menunjukkan komponen utama tampilan daftar user — hasil nyata dari operasi READ.

## Kesimpulan dan Saran 
Aplikasi ini berhasil mengimplementasikan operasi CRUD (Create, Read, Update, Delete) secara penuh menggunakan Flutter dan API eksternal ReqRes.in. Seluruh proses pengambilan, penambahan, pembaruan, dan penghapusan data berjalan dengan baik, disertai tampilan UI yang rapi serta validasi input yang berfungsi sebagaimana mestinya. Untuk pengembangan lebih lanjut, disarankan menggunakan state management seperti Provider agar pengelolaan data lebih efisien, menambahkan fitur pencarian pengguna, serta menerapkan animasi transisi agar pengalaman pengguna menjadi lebih interaktif dan menarik.
