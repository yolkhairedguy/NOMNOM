# NOMNOM

NOMNOM adalah aplikasi kantin digital berbasis Flutter yang dirancang khusus untuk lingkungan sekolah. Aplikasi ini memungkinkan siswa dan guru untuk melihat menu kantin, memesan makanan, mengelola keranjang, serta memantau status pesanan dengan mudah dan efisien.

## Fitur

* **Beranda (Home Screen)**
  Menampilkan menu unggulan, makanan favorit siswa, dan stan kantin dengan rating terbaik, dilengkapi carousel promo interaktif.

* **Halaman Kantin / Merchant**
  Melihat informasi detail stan kantin sekolah, daftar menu, harga, rating, dan ulasan dari siswa.

* **Keranjang Belanja**
  Menambahkan makanan dari satu atau beberapa stan kantin, mengatur jumlah pesanan, serta mengelola isi keranjang dengan fitur geser untuk menghapus item.

* **Checkout**
  Proses pembayaran sederhana dan aman dengan opsi **saldo kantin digital** atau **tunai**, dilengkapi ringkasan pesanan dan konfirmasi.

* **Pelacakan Pesanan**
  Memantau status pesanan secara real-time dengan indikator proses:
  *Diterima → Diproses → Siap Diambil → Selesai*

* **Riwayat Aktivitas**
  Melihat riwayat pesanan sebelumnya, detail struk pembelian, opsi pesan ulang, serta memberikan ulasan untuk kantin.

* **Rating & Ulasan**
  Melihat dan memfilter ulasan siswa berdasarkan rating, serta membaca feedback untuk setiap stan kantin.

* **Fitur Pencarian Makanan**
  Mencari menu makanan tertentu di seluruh stan kantin sekolah (modul `searchfood`).

* **Manajemen Struk**
  Melihat dan menghasilkan struk pembelian digital (modul `receipt`).

## Struktur Proyek

```
lib/
├── main.dart                    # Entry point aplikasi
├── app/
│   ├── controllers/             # GetX controller untuk manajemen state
│   ├── data/                    # Model data dan service
│   ├── modules/                 # Modul fitur
│   │   ├── activity/            # Pelacakan dan riwayat pesanan
│   │   ├── cart/                # Fitur keranjang belanja
│   │   ├── checkout/            # Pembayaran dan konfirmasi pesanan
│   │   ├── home/                # Halaman utama aplikasi
│   │   ├── merchant/            # Detail stan kantin dan menu
│   │   ├── rating/              # Rating dan ulasan
│   │   ├── receipt/             # Struk pesanan
│   │   └── searchfood/          # Pencarian makanan
│   ├── routes/                  # Konfigurasi routing aplikasi
│   └── styles/                  # Tema dan konstanta styling
└── widgets/                     # Komponen UI yang dapat digunakan kembali
```

## Instalasi

1. Pastikan Flutter sudah terpasang di sistem Anda. Jika belum, ikuti panduan resmi Flutter.

2. Clone repository:

   ```bash
   git clone <repository-url>
   cd nomnom
   ```

3. Install dependency:

   ```bash
   flutter pub get
   ```

4. Jalankan aplikasi:

   ```bash
   flutter run
   ```

## Dependencies

* **Flutter**: Framework UI
* **GetX**: State management dan routing
* **Material Design**: Komponen UI

## Cara Penggunaan

1. Buka aplikasi untuk melihat beranda dengan promo dan kategori makanan kantin.
2. Pilih stan kantin dan lihat menu yang tersedia.
3. Tambahkan makanan ke keranjang.
4. Lanjutkan ke checkout dan pilih metode pembayaran.
5. Pantau status pesanan di menu Aktivitas.
6. Berikan ulasan setelah pesanan selesai.