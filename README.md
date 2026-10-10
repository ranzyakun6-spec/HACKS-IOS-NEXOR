# AIMX IOS

Aplikasi SwiftUI pendamping untuk menyimpan preferensi latihan, melihat tips performa, dan membersihkan cache milik AIMX IOS sendiri.

## Batasan iOS

- Kontrol aim drag dan sensitivitas hanya menyimpan nilai lokal di aplikasi. iOS tidak mengizinkan aplikasi biasa mengubah input atau sensitivitas game lain.
- Tombol MAX hanya mengatur preferensi sensitivitas di layar AIMX.
- Pembersih hanya menghapus cache dalam sandbox AIMX IOS; aplikasi tidak bisa menghapus file aplikasi lain.
- Tips performa bersifat panduan. Aplikasi tidak dapat menaikkan FPS sistem atau game lain secara langsung.

## Build IPA dari Windows melalui GitHub

1. Buat repository GitHub, lalu unggah/push seluruh isi folder ini ke branch `main` atau `master`.
2. Buka tab **Actions**, pilih **Build unsigned iOS IPA**, lalu pilih **Run workflow**. Build juga berjalan otomatis saat ada push ke branch tersebut.
3. Setelah job berhasil, unduh artifact **AIMXIOS-unsigned-IPA** dan ekstrak file IPA-nya.
4. IPA hasil workflow ini **belum ditandatangani**. Tandatangani dengan sertifikat dan provisioning profile milikmu melalui Sideloadly, atau gunakan metode signing yang didukung KSign/ESign. IPA unsigned tidak bisa langsung diinstal.

GitHub Actions memakai runner macOS milik GitHub untuk menjalankan Xcode; kamu tidak perlu memiliki Mac. Tidak ada sertifikat atau Apple ID yang ditanam ke repository/workflow ini.

## Build lokal di Mac

Pasang XcodeGen, jalankan `xcodegen generate --spec project.yml`, lalu buka `AIMXIOS.xcodeproj` di Xcode untuk memilih signing team dan membuat archive bertanda tangan.
