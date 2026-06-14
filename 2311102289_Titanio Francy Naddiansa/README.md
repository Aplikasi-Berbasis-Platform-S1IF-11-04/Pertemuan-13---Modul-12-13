# Laporan: Provider dan Notifikasi pada Flutter

**Nama:Titanio Francy Naddiansa**
**NIM:2311102289**

**Nama Aplikasi:** Counter App  
**Teknologi:** Flutter, Provider, flutter_local_notifications

---

## Cara Kerja Provider

Provider adalah library *state management* yang memungkinkan data dibagikan ke seluruh widget tree tanpa perlu meneruskan data secara manual antar widget (*prop drilling*).

Pada aplikasi ini, `CounterProvider` dibuat dengan meng-*extend* `ChangeNotifier`. Di dalamnya terdapat variabel `_counter` beserta method `increment()` yang menambah nilai counter lalu memanggil `notifyListeners()`. Pemanggilan `notifyListeners()` inilah yang memberi sinyal kepada semua widget yang sedang "mendengarkan" agar melakukan rebuild dengan data terbaru.

Di `main.dart`, `CounterProvider` didaftarkan menggunakan `ChangeNotifierProvider` di dalam `MultiProvider` yang membungkus seluruh aplikasi, sehingga provider dapat diakses dari mana saja. Pada `HomeScreen`, widget `Consumer<CounterProvider>` digunakan untuk membaca nilai counter — setiap kali `notifyListeners()` dipanggil, hanya bagian `builder` di dalam `Consumer` yang di-rebuild, bukan seluruh halaman, sehingga lebih efisien.

---

## Cara Kerja Notifikasi

Aplikasi menggunakan **Local Notification** melalui package `flutter_local_notifications`, tanpa memerlukan koneksi internet maupun Firebase.

`NotificationService` dibuat dengan pola *Singleton* agar hanya ada satu instance selama aplikasi berjalan. Sebelum `runApp()` dipanggil, method `initialize()` dijalankan untuk mendaftarkan plugin ke platform Android/iOS, termasuk meminta izin notifikasi pada Android 13+.

Setiap kali tombol **Tambah (+)** ditekan, setelah provider memperbarui nilai counter, method `showCounterNotification(counter)` dipanggil. Method ini mengirim notifikasi dengan judul **"Counter Update"** dan pesan **"Nilai counter saat ini: X"** menggunakan channel ID `counter_channel`. Notification ID yang selalu bernilai `0` memastikan notifikasi baru menggantikan notifikasi sebelumnya, sehingga tidak menumpuk di panel notifikasi.

---

## Alur Singkat

```
Tombol ditekan
   → counterProvider.increment()       // nilai bertambah, UI rebuild
   → showCounterNotification(counter)  // notifikasi muncul di status bar
```
