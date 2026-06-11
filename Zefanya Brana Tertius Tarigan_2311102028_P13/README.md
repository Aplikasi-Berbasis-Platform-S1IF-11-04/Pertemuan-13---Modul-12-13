# \# Laporan Singkat Aplikasi Counter Provider dan Notifikasi

# 

# \## 1. Identitas Aplikasi

# 

# Aplikasi ini dibuat menggunakan Flutter dengan konsep satu halaman utama. Fitur utama aplikasi adalah menampilkan nilai counter, menyediakan tombol \*\*Tambah (+)\*\* untuk menambah nilai counter, tombol \*\*Reset\*\*, serta menampilkan notifikasi setiap kali nilai counter bertambah.

# 

# \## 2. Cara Kerja Provider pada Aplikasi

# 

# Pada aplikasi ini, \*\*Provider\*\* digunakan sebagai state management untuk menyimpan dan mengelola nilai counter. File yang mengatur data counter berada pada `lib/providers/counter\_provider.dart`.

# 

# Di dalam file tersebut terdapat class `CounterProvider` yang extends `ChangeNotifier`. Nilai counter disimpan dalam variabel private `\_counter`, kemudian ditampilkan melalui getter `counter`. Ketika tombol \*\*Tambah (+)\*\* ditekan, method `tambah()` akan dijalankan untuk menambah nilai counter sebanyak 1. Setelah nilai berubah, method `notifyListeners()` dipanggil agar tampilan aplikasi yang menggunakan data counter ikut diperbarui secara otomatis.

# 

# Provider didaftarkan pada file `lib/main.dart` menggunakan `ChangeNotifierProvider`. Pada halaman utama `lib/screens/home\_screen.dart`, aplikasi menggunakan `context.watch<CounterProvider>()` untuk membaca nilai counter dan memperbarui tampilan ketika data berubah. Sementara itu, `context.read<CounterProvider>()` digunakan untuk menjalankan aksi seperti menambah atau mereset counter tanpa harus terus memantau perubahan.

# 

# \## 3. Cara Kerja Notifikasi yang Digunakan

# 

# Notifikasi pada aplikasi ini menggunakan package `flutter\_local\_notifications`. Pengaturan notifikasi dibuat pada file `lib/services/notification\_service.dart`.

# 

# Saat aplikasi pertama kali dijalankan, service notifikasi diinisialisasi melalui method `init()` pada `main.dart`. Pada Android, aplikasi membuat notification channel dengan nama \*\*Counter Update\*\* dan meminta izin notifikasi jika diperlukan. Notifikasi yang digunakan adalah \*\*local notification\*\*, yaitu notifikasi yang muncul dari aplikasi sendiri tanpa perlu server atau Firebase.

# 

# Ketika tombol \*\*Tambah (+)\*\* ditekan, aplikasi menjalankan method `\_tambahCounter()` pada `home\_screen.dart`. Method tersebut menambah nilai counter melalui Provider, lalu memanggil `showCounterUpdate(counterProvider.counter)` dari `NotificationService`. Notifikasi yang muncul memiliki judul \*\*Counter Update\*\* dan pesan \*\*Nilai counter saat ini: X\*\*, dengan X adalah nilai counter terbaru.

# 

# \## 4. Kesimpulan

# 

# Aplikasi ini telah menerapkan Provider untuk mengelola state counter secara terstruktur dan menerapkan local notification untuk memberikan informasi kepada pengguna setiap kali nilai counter bertambah. Dengan pemisahan file provider, service notifikasi, screen, dan widget, struktur project menjadi lebih rapi, mudah dipahami, dan mudah dikembangkan.

# ::: 

# 

