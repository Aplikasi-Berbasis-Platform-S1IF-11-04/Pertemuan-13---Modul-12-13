1. **`CounterProvider` (State & Logika Bisnis):**
   * Kelas ini mewarisi `ChangeNotifier`. Di dalamnya terdapat *state* utama berupa variabel `_count`.
   * Ketika tombol tambah ditekan, fungsi `increment()` akan dipanggil untuk menaikkan nilai `_count`.
   * Di akhir fungsi, perintah `notifyListeners()` dieksekusi. Fungsi inilah yang bertugas "berteriak" ke seluruh aplikasi bahwa data *counter* telah berubah.

2. **`ChangeNotifierProvider` (Penyedia Akses):**
   * Di dalam `main.dart`, `MyApp` dibungkus menggunakan `ChangeNotifierProvider`. 
   * Ini memastikan bahwa objek `CounterProvider` dapat diakses oleh *widget* di bawahnya (*widget tree*), dalam hal ini adalah `CounterScreen`.

3. **`Consumer<CounterProvider>` (Pembangun UI):**
   * Pada layar utama, bagian teks angka dibungkus dengan widget `Consumer`.
   * `Consumer` bertindak sebagai pendengar setia. Begitu `notifyListeners()` berbunyi, `Consumer` akan memicu *re-build* hanya pada bagian widget teks angka saja, tanpa perlu merombak seluruh halaman (sangat efisien dibanding `setState`).

---

## 🔔 Cara Kerja Notifikasi

Sistem notifikasi pada aplikasi ini memanfaatkan `flutter_local_notifications` (Versi 22) untuk memicu notifikasi langsung dari dalam perangkat tanpa memerlukan koneksi internet atau server eksternal (FCM).

Alur kerjanya adalah sebagai berikut:

1. **Inisialisasi Sistem (`init`):**
   * Saat aplikasi pertama kali dibuka, `WidgetsFlutterBinding.ensureInitialized()` memastikan komponen native siap, lalu memanggil `NotificationService.init()`.
   * Di sini, pengaturan untuk Android dikonfigurasi menggunakan ikon bawaan aplikasi (`@mipmap/ic_launcher`).
   * Sistem juga secara otomatis meminta izin (*permission*) kepada pengguna (khusus Android 13+) melalui `requestNotificationsPermission()`.

2. **Pemicu Alur (*Triggering*):**
   * Proses pemanggilan notifikasi dijembatani langsung oleh State Management.
   * Ketika fungsi `increment()` di dalam `CounterProvider` berjalan, fungsi tersebut tidak hanya menaikkan angka, tetapi juga langsung memanggil `NotificationService.showNotification(_count)`.

3. **Menampilkan Notifikasi (`show`):**
   * Fungsi `show` menggunakan format *named arguments* untuk menentukan saluran (*channel*) Android, tingkat kepentingan (*Importance.max*), serta prioritas (*Priority.high*) agar notifikasi langsung muncul di atas layar (*heads-up notification*).
   * Judul dikunci pada teks `"Counter Update"`, dan bagian pesan (`body`) diisi secara dinamis menggunakan *string interpolation* untuk menampilkan nilai terbaru dari data Provider (`Nilai counter saat ini: $counterValue`).

---

## 🛠️ Spesifikasi Dependensi

Aplikasi ini dikembangkan menggunakan spesifikasi SDK dan *package* modern:
* **Dart SDK:** `^3.11.5` (atau versi kompatibel 2026)
* **State Management:** `provider: ^6.1.2`
* **Local Notification:** `flutter_local_notifications: ^22.0.1`

---