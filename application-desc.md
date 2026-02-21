# Cultour

**Platform Proyek**  
- Mobile App (Android & iOS)  

**Versi Saat Ini**  
1.0.0 (Beta)

**Status Proyek**  
Dalam Pengembangan Aktif (Tahap Finalisasi, Kompetisi GEMASTIK XVIII – 2025)

**Tanggal Pembaruan Terakhir**  
21 Februari 2026

**Executive Summary**  
Cultour adalah aplikasi mobile terintegrasi yang memadukan kecerdasan buatan (AI), penerjemahan bahasa, dan peta interaktif untuk memperkaya pengalaman wisata budaya Batak di Danau Toba yang inklusif dan edukatif. Aplikasi ini dirancang agar mudah diakses oleh wisatawan umum maupun penyandang disabilitas (low vision/tunanetra).

---

## Latar Belakang Proyek
Danau Toba di Sumatera Utara merupakan pusat kebudayaan Batak dengan jejak sejarah dan tradisi yang kaya. Namun, informasi warisan budaya tersebut belum mudah diakses secara langsung di lokasi, terutama bagi pengguna dengan kebutuhan aksesibilitas. Selain itu, terdapat kesenjangan adopsi digital yang memengaruhi pengalaman wisata dan literasi bahasa daerah yang masuk dalam kategori "low-resource". Aplikasi ini lahir untuk menjawab urgensi pelestarian identitas budaya Batak dan memanfaatkan peluang wisata berbasis warisan (heritage tourism) melalui inovasi teknologi yang relevan bagi generasi saat ini.

## Permasalahan Bisnis yang Diatasi
- Kurangnya informasi edukatif budaya yang terstruktur dan mudah diakses secara real-time di lokasi situs budaya.
- Keterbatasan platform interaktif untuk pembelajaran dan terjemahan berbagai bahasa Batak (Karo, Toba, Simalungun).
- Kurangnya integrasi antara lokasi navigasi destinasi dan eksplorasi nilai budaya secara bersamaan.
- Minimnya dukungan fasilitas pariwisata digital mobile yang ramah bagi penyandang disabilitas (khususnya untuk tunanetra/low vision).

## Tujuan Bisnis & Objectives (SMART)
- Menyediakan media edukasi budaya Batak yang interaktif, inklusif, dan mudah diakses menggunakan fitur aksesibilitas mobile.
- Menghadirkan teknologi AI Kamera Pintar untuk mengenali situs budaya Batak (akurasi > 80%) dan memberikan informasi instan.
- Memfasilitasi terjemahan dua arah dan percakapan real-time untuk bahasa Batak (Karo, Toba, Simalungun).
- Mengintegrasikan sistem peta interaktif untuk navigasi pariwisata berbasis budaya di Danau Toba.
- Mengimplementasikan sistem Digital Stamps / NFT Collection untuk meningkatkan keterlibatan (gamifikasi) melalui penyimpanan kenang-kenangan wisata dalam ranah digital.

## Target Audience & User Persona
- **Wisatawan Umum** (Andi, 28) - Membutuhkan rute peta wisata dan penjelasan interaktif di objek.
- **Pelajar** (Sarah, 17) - Membutuhkan konten edukasi budaya sejarah sebagai referensi belajar.
- **Peneliti Budaya** (Budi, 35) - Membutuhkan informasi rekam digital mendalam untuk referensi akademis.
- **Turis Asing** (Anna, 30) - Membutuhkan terjemahan multibahasa dan kemudahan petunjuk navigasi visual tanpa language barrier.
- **Penyandang Disabilitas / Low Vision** (Rina, 25) - Membutuhkan fitur aksesibilitas navigasi suara (TTS) dan tampilan khusus teks besar (Large Text).

## Stakeholders
- **Sponsor**: Ajang GEMASTIK XVIII
- **Product Owner/Tim Pengembang**: Tim Softwarium (Jody Edriano Pangaribuan, Andri Agung Exaudi Sigiro, Yolanda Septania Saragih)
- **Dosen Pembimbing**: Tegar Arifin Prasetyo, S.Si., M.Si. (Institut Teknologi Del)
- **End User**: Wisatawan lokal, turis asing, masyarakat Toba, pelajar, dan komunitas tunanetra.
- **External**: BPODT (Badan Pelaksana Otorita Danau Toba), Dinas Pariwisata setempat.

## Ruang Lingkup Proyek (Scope)

### In Scope
- Sistem AI Kamera Pintar untuk deteksi objek (Situs, Patung, Artefak budaya Batak).
- AI Batak Language Tutor dengan chatbot percakapan natural dan kemampuan terjemahan.
- Peta & Navigasi Wisata untuk pencarian lokasi destinasi budaya sekitar Danau Toba.
- Cultural NFT / Digital Stamp Collection sebagai apresiasi digital dari kunjungan situs heritage.
- Fitur Aksesibilitas: Text-to-Speech (TTS), Speech-to-Text (STT), dukungan Font/Text Scaling.
- Native Mobile App Development Android/iOS menggunakan framework Flutter.

### Out of Scope
- **Web App (Responsive & Progressive Web App / PWA)** - Fokus pengembangan dikhususkan di ranah perangkat bergerak mobile.
- Desktop Native Application.
- User Generated Content (Pengguna umum tidak bisa secara bebas mengunggah data situs bersejarah sendiri).
- Versi White Label untuk dijual kembali ke agency pihak ketiga.

## Fitur Utama

### Fitur Mobile App
- **AI Kamera Pintar**: Mengenali objek menggunakan Machine Learning berbasis Android Vision (TensorFlow), memaparkan detail sejarah baik berupa visual (teks yang disesuaikan ukurannya) maupun audio (narator suara) saat objek dikenali.
- **AI Batak Language Tutor**: Chatbot dua arah untuk bertanya, berlatih bahasa Batak, dan rekomendasi konteks kultural.
- **Cultural NFT Collection**: Integrasi koleksi "Digital Museum" yang mencatat waktu kunjungan ketika pengguna menscan QR Code atau memfoto situs warisan; pencatatan ini disimpan dalam Blockchain Polygon & IPFS.
- **Peta & Navigasi Budaya**: Menampilkan daftar destinasi populer, pencarian landmark (Google Maps API), hingga mendapatkan rute arah di kawasan Toba.
- **Aksesibilitas Terpadu**: Kompatibilitas dengan fitur TalkBack dan pengaturan kontras layar spesifik bagi penyandang tunanetra atau low vision.

### Fitur Web App
- *Tidak ada (Out of Scope)*

### Fitur Cross-Platform
- -

## Persyaratan Fungsional (Functional Requirements)
- Fungsi deteksi on-device dan interkoneksi cloud mampu merespons scan objek dan menampilkan insight situs kurang dari 3 detik.
- Aplikasi mampu menerjemahkan text/voice Bahasa Indonesia ke Bahasa Batak di dalam UI Chat.
- Fitur peta mampu menampilkan titik turisme, jarak, dan menyambungkan pengguna ke jalan navigasi.
- Memberikan opsi mencetak (minting) Digital Stamp/NFT langsung ke dompet aplikasi setelah scan berhasil di spot lokasi.

## Persyaratan Non-Fungsional (NFR)
- **Performance**: Waktu deteksi AI (TensorFlow Lite) maksimal 3 detik; respon Chatbot (OpenAI Model) maksimal 2 detik di tingkat jaringan standar.
- **Reliability**: Layanan pendukung berbasis Firebase dan AI beroperasi 99% Uptime.
- **Security**: Autentikasi terlindung enkripsi, NFT dijamin menggunakan smart contract blockchain lokal.
- **Accessibility**: Standardisasi panduan aplikasi difable untuk warna, kecerahan, dan kemudahan narator (WCAG Compliance).
- **Portabilitas**: Native Mobile OS (Android minimum versi 8.0 Oreo).
- **Scalability**: Arsitektur server (Firebase & Cloud Functions) memudahkan panambahan konten heritage maupun kosakata tanpa update kode menyeluruh.

## Tech Stack (Lengkap)

| Layer              | Technology                                      | Versi / Keterangan                  |
|--------------------|--------------------------------------------------|-------------------------------------|
| **Mobile**         | Flutter + Dart                                   | Android/iOS Cross Platform          |
| **Backend/BaaS**   | Firebase                                         | Auth, Cloud Firestore, Real-time DB |
| **Edge AI/Vision** | TensorFlow Lite, MediaPipe                       | Object Detection On-device          |
| **Cloud AI (NLP)** | OpenAI API / GPT                                 | Natural Language Processing Chatbot |
| **Maps & Lokasi**  | Google Maps API                                  | Peta Wisata interaktif dan routing  |
| **Web3/Blockchain**| Polygon Blockchain, IPFS                         | Minting & Storage NFT Aset koleksi  |
| **Library Native** | System TTS & STT, QR Scanner API                 | Voice navigation, input data akses  |

## Arsitektur Sistem
- **Client-Server Architecture**: App Android mengonsumsi API backend (Firebase & Layanan AI OpenAI).
- **Hybrid AI Processing**: Model Machine Learning visual ringan berada secara offline di klien via TensorFlow Lite; sementara processing berat NLP dilakukan API Cloud OpenAI.
- **Distributed NFT Ledgers**: Menghubungkan client secara async ke node Polygon untuk menerbitkan identitas digital NFT.

## Integrasi Pihak Ketiga
- **Layanan Pemetaan**: Layanan Web Api Google Maps / Places API.
- **Layanan AI / NLP Language**: OpenAI Engine.
- **Layanan Smart Contract/Ledger**: Polygon Edge.
- **Penyimpanan Terdistribusi**: InterPlanetary File System (IPFS).

## Keamanan & Compliance
- Keamanan enkripsi password Firebase Auth dan sesi JSON Web Tokens.
- Keamanan desentralisasi data NFT dengan metode Immutable Storage di platform IPFS.

## Project Management & Methodology
- **Agile Scrum Method**: Penggunaan fase interatif/sprint selama durasi pra-kompetisi (Durasi 8 Minggu). Memisahkan backlog per modul seperti AI Modul, Integrasi Chatbot, Modul Blockchain, dan Accessiblity Integrations.

## Git Workflow
- Version control sentral melalui GitHub. Branching spesifik berbasis fitur.

## Testing Strategy
- **Blackbox Testing**: Pengujian modul secara struktural dari sisi front-end atas output terjemahan dan deteksi model AI.
- **User Acceptance Test (UAT)**: Mengumpulkan umpan balik end-user khususnya dari pihak disabilitas terhadap kemudahan Voice Assist.
- **Accessibility Testing**: Standar verifikasi interaksi TalkBack untuk low-visibility visioning (Standar WCAG 2.1).
- **Performance Testing**: Tes stress durasi respon detektor AI / konektivitas layanan Blockchain.
- **Security Testing**: Validasi akses dan pemanggilan API.

## Deployment & Infrastructure
- Perilisan Beta pada Android melalui paket APK Installer.
- Integrasi serverless infrastruktur backend (BaaS Firebase Environment).

## Monitoring, Logging & Alerting
- Crashlytics untuk evaluasi bugs pada runtime Android.

## Backup & Disaster Recovery
- Basis data Firebase dan penyimpanan desentralisasi IPFS untuk mengatasi Single Point Of Failure untuk storage NFT koleksi pengguna.

## Risks & Mitigation
- **Kendala cahaya atau model visual**: Peningkatan parameter dan teknik optimasi kamera low light sebelum scanning dijalankan oleh TensorFlow.
- **Keterbatasan API Calls (OpenAI/Google)**: Menyiapkan batasan pemanggilan fitur / Rate limiting per user IP untuk mencegah penyalahgunaan API di backend.

## Success Metrics / KPIs
(Diambil dari evaluasi tes final):
- Edukasi Budaya / Chatbot AI: 94% Tingkat Keberhasilan.
- Aksesibilitas Disabilitas & Talkback: 92% Keberhasilan.
- Fungsi Cetak (Minting) Koleksi NFT: 90% Keberhasilan.
- Pencarian Destinasi Wisata Peta: 88% Keberhasilan.
- Deteksi Objek Gambar Visual Kamer: 80% Keberhasilan.

## Roadmap & Future Enhancements
- Integrasi ke berbagai event pariwisata Toba lainnya secara real-time maupun booking system.
- Perluasan basis algoritma NMT dengan bahasa selain Karo/Toba/Simalungun di Indonesia.
- Melanjutkan open collaboration bersama Dinas Parawisata BPODT.
- Implementasi fungsional di platform iOS secara menyeluruh.

## Tim Pengembang & RACI
- **Jody Edriano Pangaribuan** (Institut Teknologi Del)
- **Andri Agung Exaudi Sigiro** (Institut Teknologi Del)
- **Yolanda Septania Saragih** (Institut Teknologi Del)

## Jadwal Proyek (Milestone Utama)
- **M1 (Minggu 1-2)**: Riset Kebutuhan Pengguna, target kelompok Disabilitas.
- **M2 (Minggu 2-5)**: Training ML/Pengembangan Modul AI Kamera.
- **M3 (Minggu 4-6)**: Pengaturan Endpoint Chatbot AI Language Tutor.
- **M4 (Minggu 5-7)**: Implementasi Sistem Koleksi Blockchain NFT.
- **M5 (Minggu 6-7)**: UAT Pengujian Inklusivitas End-User.
- **M6 (Minggu 8)**: Perbaikan Bug minor & Rilis Beta untuk kompetisi.

## Dokumentasi Lengkap
- Proposal: Dokumen Eksplorasi Budaya Batak Cerdas & Ramah Disabilitas.
- Demo Video: Terdapat pada shortlink proposal.
- GitHub Source: Github Repository Cultour App.

## Glossary
- **UAT**: User Acceptance Test
- **TTS & STT**: Text-to-Speech & Speech-to-Text
- **NFT**: Non-Fungible Token
- **BaaS**: Backend-as-a-Service
- **WCAG**: Web Content Accessibility Guidelines

## Changelog
- **v1.0.0 (Beta)** – 21 Feb 2026: Rilis dokumen berdasarkan proposal proyek GEMASTIK XVIII - 2025.

## Lisensi
Hak Cipta Softwarium & Institut Teknologi Del 2025.

---

**Dibuat oleh**: Tim Softwarium  
**Approved by**: Tegar Arifin Prasetyo, S.Si., M.Si.  

---
