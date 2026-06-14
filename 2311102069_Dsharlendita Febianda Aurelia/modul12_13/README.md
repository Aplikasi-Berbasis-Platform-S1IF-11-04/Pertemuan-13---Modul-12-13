# Laporan Praktik Modul 12–13

## Implementasi Provider dan Notifikasi pada Flutter

**Nama:** Dsharlendita Febianda Aurelia
**NIM:** 2311102069

### Cara Kerja Provider pada Aplikasi

Pada aplikasi ini digunakan package **Provider** sebagai state management untuk mengelola nilai counter. Provider bekerja dengan membuat class `CounterProvider` yang mewarisi `ChangeNotifier`. Class tersebut menyimpan nilai counter dan menyediakan method `increment()` untuk menambah nilai counter.

Ketika tombol tambah (`+`) ditekan, method `increment()` akan dijalankan sehingga nilai counter bertambah satu. Setelah itu, method `notifyListeners()` dipanggil untuk memberi tahu widget yang menggunakan Provider bahwa terjadi perubahan data. Akibatnya, tampilan nilai counter pada layar akan diperbarui secara otomatis tanpa perlu melakukan refresh secara manual.

### Cara Kerja Notifikasi

Pada aplikasi ini digunakan package **flutter_local_notifications** untuk menampilkan notifikasi lokal pada perangkat Android. Sebelum digunakan, notifikasi diinisialisasi melalui `NotificationService.init()` saat aplikasi dijalankan.

Setiap kali tombol tambah (`+`) ditekan, aplikasi akan memanggil method `showNotification()` yang terdapat pada `NotificationService`. Method tersebut menampilkan notifikasi dengan judul **"Counter Update"** dan pesan **"Nilai counter saat ini: X"**, di mana X merupakan nilai counter terbaru.

Dengan demikian, setiap perubahan nilai counter akan langsung memberikan informasi kepada pengguna melalui notifikasi lokal yang muncul pada perangkat.

<table>
  <tr>
    <td align="center">
      <img src="Screenshot/Output%201.png" width="200"><br>
      Output 1
    </td>
    <td align="center">
      <img src="Screenshot/Output%202.png" width="200"><br>
      Output 2
    </td>
  </tr>
</table>
