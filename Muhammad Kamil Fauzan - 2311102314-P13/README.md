# Laporan Singkat Provider dan Notifikasi Flutter

## 1. Cara Kerja Provider pada Aplikasi

Pada aplikasi ini, **Provider** digunakan untuk menyimpan dan mengatur nilai counter. Nilai counter tidak langsung diletakkan di halaman tampilan, tetapi disimpan di dalam class khusus, yaitu `CounterProvider`.

Di dalam `CounterProvider`, terdapat variabel untuk menyimpan angka counter. Ketika tombol **Tambah (+1)** ditekan, aplikasi akan memanggil fungsi untuk menambah nilai counter sebanyak satu. Setelah nilainya berubah, Provider menjalankan `notifyListeners()`. Perintah ini memberi tahu tampilan bahwa ada data yang berubah, sehingga angka counter di layar ikut diperbarui secara otomatis.

Dengan menggunakan Provider, kode aplikasi menjadi lebih rapi karena bagian penyimpanan data dan bagian tampilan dipisahkan. Tampilan hanya bertugas menampilkan nilai counter, sedangkan Provider bertugas mengatur perubahan nilainya.

## 2. Cara Kerja Notifikasi yang Digunakan

Notifikasi pada aplikasi ini berjalan ketika pengguna menekan tombol **Tambah (+1)**. Setelah nilai counter bertambah, aplikasi akan menampilkan notifikasi dengan judul **Counter Update** dan pesan berisi nilai counter terbaru, misalnya: **Nilai counter saat ini: 3**.

Karena aplikasi dijalankan melalui Chrome, notifikasi yang digunakan adalah notifikasi berbasis web browser. Saat pertama kali aplikasi dibuka, browser akan meminta izin untuk menampilkan notifikasi. Jika pengguna memilih **Allow/Izinkan**, maka setiap kali counter bertambah, notifikasi dapat muncul di perangkat.

Secara sederhana, alurnya adalah pengguna menekan tombol tambah, nilai counter berubah melalui Provider, lalu aplikasi menampilkan notifikasi yang berisi nilai counter terbaru. Dengan begitu, pengguna bisa melihat perubahan counter langsung di layar dan juga mendapatkan pemberitahuan melalui notifikasi.
::: 
