# 🏛️ Cultour - Aplikasi Wisata Indonesia

Aplikasi mobile untuk menjelajahi tempat wisata di Indonesia dengan fitur kamera AI, tutor bahasa, dan koleksi prangko digital.

## 🚀 Fitur Utama

- **🏠 Beranda**: Jelajahi tempat wisata populer di Indonesia
- **📷 Kamera AI**: Identifikasi tempat wisata menggunakan kamera (Coming Soon)
- **🗣️ Tutor Bahasa**: Belajar bahasa daerah dan asing (Coming Soon)
- **🎫 Koleksi Prangko**: Kumpulkan prangko digital dari tempat yang dikunjungi (Coming Soon)
- **👤 Profil**: Kelola akun dan riwayat perjalanan

## 🏗️ Arsitektur

Aplikasi ini menggunakan **Clean Architecture** dengan struktur sebagai berikut:

```
lib/
├── core/
│   ├── constants/          # Konstanta aplikasi (warna, string, dimensi)
│   ├── theme/              # Tema dan styling
│   ├── error/              # Error handling
│   ├── utils/              # Utility functions
│   └── di/                 # Dependency injection
├── features/
│   ├── home/               # Fitur beranda
│   ├── camera/             # Fitur kamera AI
│   ├── language/           # Fitur tutor bahasa
│   ├── stamps/             # Fitur koleksi prangko
│   └── profile/            # Fitur profil
│       ├── domain/         # Business logic layer
│       ├── data/           # Data layer
│       └── presentation/   # UI layer
└── shared/
    ├── widgets/            # Widget yang digunakan bersama
    └── constants/          # Konstanta bersama
```

## 📱 Teknologi yang Digunakan

- **Flutter 3.x** - Framework UI
- **Dart** - Bahasa pemrograman
- **BLoC** - State management
- **GetIt** - Dependency injection
- **Dartz** - Functional programming
- **Cached Network Image** - Image caching
- **Equatable** - Value equality

## 🎨 Design System

- **Warna Utama**: `#1990E6` (Biru)
- **Font**: Roboto
- **Bahasa**: Bahasa Indonesia
- **Material Design 3** dengan custom theming

## 🚀 Cara Menjalankan

1. Pastikan Flutter sudah terinstall
2. Clone repository ini
3. Jalankan command berikut:

```bash
flutter pub get
flutter run
```

## 📋 Status Pengembangan

- ✅ Struktur Clean Architecture
- ✅ Beranda dengan grid tempat wisata
- ✅ Bottom navigation dengan 5 tab
- ✅ State management dengan BLoC
- ✅ Dependency injection
- ✅ Indonesian localization
- 🚧 Kamera AI (Coming Soon)
- 🚧 Tutor Bahasa (Coming Soon)
- 🚧 Koleksi Prangko (Coming Soon)
- 🚧 Fitur Profil Lengkap (Coming Soon)

## 🤝 Kontribusi

Silakan buat issue atau pull request untuk berkontribusi pada pengembangan aplikasi ini.

## 📄 Lisensi

Project ini dibuat untuk keperluan pengembangan aplikasi wisata Indonesia.
