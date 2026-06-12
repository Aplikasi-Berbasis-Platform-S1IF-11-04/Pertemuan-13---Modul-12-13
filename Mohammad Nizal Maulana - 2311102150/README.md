# Laporan Praktik Modul 12 & 13

## Implementasi Provider dan Notifikasi pada Flutter

### Cara Kerja Provider

Pada aplikasi ini, Provider digunakan sebagai state management untuk mengelola nilai counter. Nilai counter disimpan dalam kelas `CounterProvider` yang merupakan turunan dari `ChangeNotifier`. Kelas ini bertanggung jawab untuk menyimpan data dan mengatur perubahan state pada aplikasi.

Ketika pengguna menekan tombol tambah (+), fungsi `incrementCounter()` akan dijalankan. Fungsi tersebut menambahkan nilai counter sebesar satu, kemudian memanggil `notifyListeners()`. Pemanggilan `notifyListeners()` akan memberi tahu seluruh widget yang menggunakan Provider bahwa telah terjadi perubahan data. Dengan demikian, tampilan nilai counter pada layar akan diperbarui secara otomatis sesuai dengan nilai terbaru tanpa perlu melakukan refresh secara manual.

Provider membantu memisahkan logika pengelolaan data dari tampilan sehingga kode menjadi lebih terstruktur, mudah dipelihara, dan mudah dikembangkan.

### Cara Kerja Notifikasi

Aplikasi menggunakan package `flutter_local_notifications` untuk menampilkan notifikasi lokal pada perangkat Android. Sebelum digunakan, notifikasi diinisialisasi melalui kelas `NotificationService` pada saat aplikasi dijalankan.

Setiap kali nilai counter bertambah, fungsi `showNotification()` akan dipanggil. Fungsi ini membuat notifikasi dengan judul **"Counter Update"** dan pesan **"Nilai counter saat ini: X"**, di mana X merupakan nilai counter terbaru. Setelah notifikasi dibuat, sistem Android akan menampilkannya pada perangkat pengguna.

Dengan penggunaan notifikasi lokal, pengguna dapat langsung mengetahui perubahan nilai counter setiap kali tombol tambah ditekan tanpa perlu memperhatikan tampilan aplikasi secara terus-menerus.
