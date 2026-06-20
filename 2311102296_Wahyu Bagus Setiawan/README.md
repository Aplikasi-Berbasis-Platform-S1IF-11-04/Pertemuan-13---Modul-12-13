<div style="font-family: 'Times New Roman', Times, serif;">

<div align="center">
  <br />

  <h1>LAPORAN PRAKTIKUM <br>
  PEMROGRAMAN BERBASIS PLATFORM
  </h1>

  <br />

  <h3>TUGAS PERTEMUAN - 13<br>
    Praktikum Flutter — Implementasi State Management Provider dan Notifikasi Reaktif (Web Optimized)
  </h3>

  <br />

  <img src="ss/logotelu.jpeg" alt ="logo" width = "300">

  <br />
  <br />
  <br />

  <h3>Disusun Oleh :</h3>

  <p>
    <strong> Wahyu Bagus Setiawan </strong><br>
    <strong> 2311102296 </strong><br>
    <strong> IF-11-04 </strong>
  </p>

  <br />

  <h3>Dosen Pengampu :</h3>

  <p>
    <strong> Cahyo Prihantoro, S.Kom., M.Eng. </strong>
  </p>

  <br />

  <h3>LABORATORIUM REKAYASA PERANGKAT LUNAK
  <br>FAKULTAS INFORMATIKA <br> UNIVERSITAS TELKOM PURWOKERTO  <br>2026</h3>
</div>

<hr>

## 1. Penjelasan Singkat

Pada tugas **Pertemuan 13** ini, praktikum berfokus pada penerapan **State Management Provider** dan sistem **Notifikasi Reaktif** pada framework Flutter. Aplikasi didesain secara adaptif berupa *Counter Application* (Penghitung Angka) dengan konsep **modern, minimalis, dan fungsional** menggunakan tema **Deep Purple Dark Mode** serta dioptimalkan secara khusus agar berjalan 100% lancar di platform **Web Browser (Google Chrome)** tanpa kendala *compiler biner native*.

Konsep utama yang diterapkan:

1. **State Management Berbasis Provider** : Menggunakan package `provider` dengan memanfaatkan arsitektur kelas `ChangeNotifier`. Komponen logika bisnis (state angka) dipisahkan sepenuhnya dari lapisan tampilan (UI), sehingga pembaruan data terjadi secara efisien dan terpusat.
2. **Reactive Local Notifications (Web SnackBar Engine)** : Guna menghindari kegagalan *crash* pada platform Google Chrome akibat pembatasan pustaka biner HP (`flutter_local_notifications`), sistem notifikasi dialihkan secara cerdas menggunakan komponen *Floating SnackBar* interaktif yang dipicu langsung dari dalam kelas Provider sesaat setelah state angka bertambah.
3. **Automated State Notification Flow** : Setiap kali tombol aksi tambah ditekan, fungsi di dalam Provider akan menginkrementasi data, memerintahkan `notifyListeners()` untuk melakukan render ulang widget secara parsial, dan secara simultan meluncurkan pop-up notifikasi bertajuk "Counter Update" di bagian bawah layar.
4. **Clean Web UI Architecture** : Antarmuka dibangun di atas kontainer bertema gelap (`Brightness.dark`) dengan aksen warna *Deep Purple*. Menampilkan kartu identitas mahasiswa formal, teks angka counter berukuran besar yang reaktif, serta tombol aksi ergonomis di pojok kanan bawah.

---

## 2. Penjelasan Singkat Tiap File / Widget

Berikut adalah struktur komponen dan file utama yang diimplementasikan dalam proyek ini:

### `lib/main.dart`
- Bertindak sebagai **entri utama (entry point)** sekaligus wadah arsitektur aplikasi. Memanggil `WidgetsFlutterBinding.ensureInitialized()` untuk memastikan kesiapan framework Flutter.
- Di dalam fungsi `main()`, root widget `MyApp` dibungkus menggunakan `ChangeNotifierProvider` agar state global dari `CounterProvider` dapat diakses dan dikonsumsi oleh seluruh sub-widget di dalam pohon aplikasi (*widget tree*).
- **`CounterProvider`** (`ChangeNotifier`): Kelas manajer state yang menyimpan data privat angka (`_counter`). Menyediakan fungsi `incrementCounter()` untuk menaikkan nilai angka, memicu rekonstruksi UI, serta memanggil metode privat `_showWebNotification()` untuk memunculkan notifikasi pop-up.
- **`MyApp`** (`StatelessWidget`): Mengonfigurasi `MaterialApp` dengan skema warna `ThemeData.dark()` berbasis *seed color* Deep Purple, menonaktifkan banner debug, serta memuat halaman utama `MyHomePage`.
- **`MyHomePage`** (`StatelessWidget`): Halaman dashboard utama yang mengonsumsi data dari Provider menggunakan perintah reaktif `Provider.of<CounterProvider>(context)`. Widget ini menyajikan kartu informasi Nama dan NIM mahasiswa, representasi teks angka counter di tengah layar, serta `FloatingActionButton` sebagai pemicu aksi.

---

## 3. Langkah-langkah Pembuatan Aplikasi

### Langkah 1 — Inisialisasi Project Flutter
Buat proyek baru yang steril khusus untuk running platform web melalui terminal:
```bash
flutter create hydration_tracker
cd hydration_tracker
### Langkah 2 — Tambahkan Dependencies di `pubspec.yaml`

Buka berkas `pubspec.yaml` dan tambahkan library manajerial state reaktif **Provider** di dalam blok dependensi aplikasi:

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.5
```

Unduh paket pustaka eksternal tersebut dengan mengetikkan perintah berikut pada terminal:

```bash
flutter pub get
```

---

### Langkah 3 — Eksekusi Source Code Utama

Buka file `lib/main.dart`, bersihkan seluruh kode bawaan Flutter, lalu implementasikan arsitektur aplikasi menggunakan **State Management Provider**. Pada tahap ini dibuat kelas `CounterProvider` yang bertugas menyimpan state angka, mengelola proses increment counter, serta memicu notifikasi reaktif setiap kali data berubah.

Struktur kode juga mencakup:

* `ChangeNotifier` sebagai pengelola state aplikasi.
* `ChangeNotifierProvider` sebagai penyedia state global.
* `Provider.of<CounterProvider>(context)` untuk mengakses data secara reaktif.
* Implementasi notifikasi berbasis `SnackBar` yang kompatibel dengan platform Web.
* Antarmuka modern menggunakan tema **Deep Purple Dark Mode**.

---

### Langkah 4 — Menjalankan Aplikasi di Google Chrome

Pastikan seluruh file telah disimpan, kemudian jalankan aplikasi langsung ke browser Google Chrome menggunakan perintah berikut:

```bash
flutter run -d chrome
```

Jika proses build berhasil, aplikasi akan terbuka secara otomatis pada browser dan seluruh fitur Provider serta notifikasi reaktif dapat diuji secara langsung.

---

## 4. Struktur File Proyek

Struktur folder akhir dari project ini tersusun secara minimalis dan rapi sebagai berikut:

```plaintext
hydration_tracker/
├── lib/
│   └── main.dart
│       └── Entrypoint, HomePage, CounterProvider, & Logika Notifikasi Web
└── pubspec.yaml
    └── Manajemen paket dependensi proyek Flutter (Provider)
```

---

## 5. Screenshot Hasil Tampilan



---

## 6. Kesimpulan

Berdasarkan hasil implementasi dan pengujian aplikasi, dapat diperoleh beberapa kesimpulan sebagai berikut:

### 1. Pemisahan Logika Bisnis

Penggunaan **State Management Provider** terbukti mampu memisahkan komponen pengolah data dari komponen visual secara lebih terstruktur. Pendekatan ini mengurangi ketergantungan terhadap `StatefulWidget` lokal sehingga pengelolaan state menjadi lebih mudah, bersih, dan mudah dikembangkan.

### 2. Solusi Lintas Platform (*Cross-Platform Optimization*)

Pengalihan sistem notifikasi dari mekanisme native Android menuju komponen **SnackBar** bawaan Flutter menjadi solusi yang efektif untuk menjaga kompatibilitas aplikasi pada platform Web, khususnya Google Chrome, tanpa mengalami kendala kompilasi pustaka native.

### 3. Efisiensi Pembaruan Widget

Melalui mekanisme `notifyListeners()`, Flutter hanya melakukan pembaruan pada widget yang membutuhkan data terbaru. Pendekatan ini meningkatkan efisiensi proses rendering sekaligus membantu mengoptimalkan penggunaan sumber daya perangkat saat aplikasi dijalankan.
