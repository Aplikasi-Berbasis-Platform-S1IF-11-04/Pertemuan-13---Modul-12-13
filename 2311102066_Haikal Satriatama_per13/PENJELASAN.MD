Implementasi Provider dan Notifikasi pada Flutter
Cara Kerja Provider
Provider digunakan sebagai state management untuk menyimpan dan mengelola nilai counter. Nilai counter disimpan pada class CounterProvider yang merupakan turunan dari ChangeNotifier. Setiap kali tombol tambah ditekan, fungsi increment() dijalankan sehingga nilai counter bertambah satu dan notifyListeners() dipanggil untuk memperbarui tampilan secara otomatis.

Cara Kerja Notifikasi
Aplikasi menggunakan package flutter_local_notifications untuk menampilkan notifikasi lokal. Setelah nilai counter bertambah, aplikasi memanggil fungsi showNotification() yang menampilkan notifikasi dengan judul "Counter Update" dan isi pesan berupa nilai counter terbaru. Notifikasi muncul setiap kali pengguna menekan tombol tambah.