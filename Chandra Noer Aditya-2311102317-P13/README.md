# Laporan Singkat Aplikasi Counter dengan Provider dan Notifikasi

## 1. Gambaran Umum Aplikasi

Aplikasi ini merupakan aplikasi Flutter sederhana yang dibuat dalam satu halaman utama. Fungsi utama dari aplikasi ini adalah menampilkan angka counter, menambah nilai counter melalui tombol **Tambah (+)**, mengembalikan nilai counter ke awal melalui tombol **Reset**, serta menampilkan notifikasi setiap kali nilai counter berhasil ditambahkan.

## 2. Cara Kerja Provider pada Aplikasi

Pada project ini, **Provider** digunakan sebagai pengelola state atau data yang dapat berubah selama aplikasi berjalan. State yang dikelola pada aplikasi ini adalah nilai counter. Pengaturan counter dibuat pada file `lib/providers/counter_provider.dart`.

Di dalam file tersebut terdapat class `CounterProvider` yang menggunakan `ChangeNotifier`. Nilai counter disimpan dalam variabel `_counter` dan dapat diakses melalui getter `counter`. Ketika pengguna menekan tombol **Tambah (+)**, method `tambah()` akan dipanggil untuk menaikkan nilai counter sebanyak satu angka. Setelah nilai counter berubah, `notifyListeners()` dijalankan agar tampilan aplikasi yang menggunakan data tersebut dapat diperbarui secara otomatis.

Provider kemudian didaftarkan pada file `lib/main.dart` menggunakan `ChangeNotifierProvider`. Pada halaman utama di file `lib/screens/home_screen.dart`, nilai counter dibaca menggunakan `context.watch<CounterProvider>()` agar tampilan ikut berubah ketika data diperbarui. Sementara itu, `context.read<CounterProvider>()` digunakan untuk menjalankan fungsi seperti menambah dan mereset counter tanpa harus melakukan pemantauan perubahan secara terus-menerus.

## 3. Cara Kerja Notifikasi pada Aplikasi

Fitur notifikasi pada aplikasi ini menggunakan package `flutter_local_notifications`. Seluruh konfigurasi notifikasi dibuat pada file `lib/services/notification_service.dart`.

Ketika aplikasi dijalankan, service notifikasi akan diinisialisasi terlebih dahulu melalui method `init()` yang dipanggil pada file `main.dart`. Pada perangkat Android, aplikasi membuat notification channel dengan nama **Counter Update**. Selain itu, aplikasi juga meminta izin notifikasi apabila perangkat membutuhkan permission khusus.

Jenis notifikasi yang digunakan adalah **local notification**, yaitu notifikasi yang dikirim langsung dari aplikasi tanpa bantuan server eksternal atau Firebase. Saat tombol **Tambah (+)** ditekan, aplikasi akan menjalankan method `_tambahCounter()` pada file `home_screen.dart`. Method tersebut akan menambah nilai counter melalui Provider, lalu memanggil fungsi `showCounterUpdate(counterProvider.counter)` dari `NotificationService`.

Notifikasi yang ditampilkan memiliki judul **Counter Update** dengan isi pesan **Nilai counter saat ini: X**, di mana X merupakan nilai counter terbaru setelah tombol tambah ditekan.

## 4. Kesimpulan

Aplikasi ini berhasil menerapkan Provider sebagai pengelola state counter dan menggunakan local notification untuk memberikan pemberitahuan kepada pengguna ketika nilai counter bertambah. Dengan pembagian file menjadi provider, service, screen, dan widget, struktur project menjadi lebih rapi, mudah dipahami, serta lebih mudah dikembangkan kembali.
