# Laporan Singkat Praktikum - Modul 12 & 13
**Implementasi Provider dan Notifikasi pada Flutter**

### 1. Cara Kerja Provider pada Aplikasi
Pola State Management Provider pada aplikasi ini bekerja dengan memisahkan logika bisnis (data counter) dari tampilan antarmuka (UI) menggunakan beberapa komponen utama:
* **`CounterProvider` (ChangeNotifier):** Bertindak sebagai kelas penyimpanan state. Variabel `_counter` diisolasi agar tidak bisa diubah langsung dari luar secara sembarangan, dan hanya bisa dimanipulasi lewat fungsi `incrementCounter()`.
* **`notifyListeners()`:** Fungsi krusial di dalam kelas Provider yang bertugas mengirimkan sinyal siaran (*broadcast signal*) ke seluruh arsitektur aplikasi setiap kali terjadi perubahan data pada nilai counter.
* **`ChangeNotifierProvider`:** Dipasang di tingkat paling atas (*root*) aplikasi untuk mendaftarkan dan membagikan akses `CounterProvider` ke seluruh pohon widget di bawahnya.
* **`Consumer<CounterProvider>`:** Widget konsumen khusus yang diletakkan di area teks angka. Widget ini secara aktif mendengarkan sinyal dari `notifyListeners()`. Ketika sinyal diterima, hanya area di dalam blok `Consumer` ini saja yang dibangun ulang (*rebuild*), sementara widget lain di luar blok tersebut tidak ikut diproses, sehingga performa aplikasi menjadi jauh lebih efisien.

### 2. Cara Kerja Notifikasi yang Digunakan
Sistem notifikasi yang diimplementasikan pada aplikasi ini mengadopsi mekanisme pemberitahuan lokal instan yang dipicu langsung berdasarkan urutan instruksi linier (*event-driven*):
* **Pemicu Aksi (*Trigger Event*):** Ketika pengguna menekan `FloatingActionButton` (+), aplikasi melakukan dua tugas berurutan: memperbarui data pada Provider, kemudian menangkap nilai integer terbaru tersebut melalui fungsi `provider.counter`.
* **Pembuatan Objek Notifikasi:** Nilai terbaru dikirim ke fungsi `_picuNotifikasiLokal` untuk diinjeksikan ke dalam teks parameter pesan notifikasi secara dinamis.
* **Manajemen Antrean Visual:** Perintah `ScaffoldMessenger.of(context).removeCurrentSnackBar()` dijalankan terlebih dahulu untuk langsung menghapus notifikasi lama yang sedang tampil, mencegah terjadinya tumpukan antrean visual yang lambat.
* **Pemunculan Notifikasi Melayang:** Menggunakan arsitektur `SnackBar` dengan parameter `SnackBarBehavior.floating`. Komponen ini memaksa sistem antarmuka menampilkan kotak pemberitahuan terpisah yang melayang di atas UI utama, lengkap dengan ikon indikator aktif, judul *"Counter Update"*, dan pesan informatif yang menampilkan angka real-time yang sah bertindak sebagai sistem notifikasi lokal terintegrasi.
