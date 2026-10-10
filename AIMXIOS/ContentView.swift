import SwiftUI

struct ContentView: View {
    @AppStorage("aimDragLevel") private var aimDragLevel = 55.0
    @AppStorage("sensitivityLevel") private var sensitivityLevel = 75.0
    @AppStorage("aimxProfile") private var aimxProfile = "Balanced"
    @State private var alertMessage = ""
    @State private var isShowingAlert = false

    private let accent = Color(red: 0.39, green: 0.96, blue: 0.76)

    var body: some View {
        ZStack {
            ZStack(alignment: .topTrailing) {
                Color(red: 0.035, green: 0.055, blue: 0.09)
                Circle()
                    .fill(accent.opacity(0.10))
                    .frame(width: 230, height: 230)
                    .blur(radius: 90)
                    .offset(x: 90, y: 10)
                Circle()
                    .fill(Color.blue.opacity(0.08))
                    .frame(width: 180, height: 180)
                    .blur(radius: 80)
                    .offset(x: -250, y: 430)
            }
            .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 22) {
                    header
                    heroCard
                    profileCard
                    tuningCard
                    fpsCard
                    cleanerCard
                    footer
                }
                .padding(.horizontal, 20)
                .padding(.top, 14)
                .padding(.bottom, 32)
            }
        }
        .preferredColorScheme(.dark)
        .alert("AIMX IOS", isPresented: $isShowingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("AIMX IOS")
                    .font(.system(size: 23, weight: .black, design: .rounded))
                    .tracking(1.2)
                    .foregroundStyle(.white)
                Text("PERFORMANCE STUDIO")
                    .font(.system(size: 9, weight: .bold, design: .rounded))
                    .tracking(2.1)
                    .foregroundStyle(accent)
            }
            Spacer()
            HStack(spacing: 7) {
                Circle().fill(accent).frame(width: 6, height: 6)
                Text("READY")
                    .font(.system(size: 9, weight: .black, design: .rounded))
                    .tracking(1)
            }
            .foregroundStyle(accent)
            .padding(.horizontal, 12)
            .padding(.vertical, 9)
            .background(accent.opacity(0.09), in: Capsule())
            .overlay(Capsule().stroke(accent.opacity(0.18), lineWidth: 1))
        }
    }

    private var heroCard: some View {
        ZStack(alignment: .topTrailing) {
            Image(systemName: "scope")
                .font(.system(size: 100, weight: .ultraLight))
                .foregroundStyle(.white.opacity(0.055))
                .rotationEffect(.degrees(-18))
                .offset(x: 22, y: 16)

            VStack(alignment: .leading, spacing: 15) {
                HStack(spacing: 7) {
                    Image(systemName: "sparkle")
                        .font(.system(size: 10, weight: .bold))
                    Text("CONTROL YOUR FLOW")
                        .font(.system(size: 9, weight: .black, design: .rounded))
                        .tracking(1.7)
                }
                .foregroundStyle(accent)

                Text("Atur feel.\nMain lebih nyaman.")
                    .font(.system(size: 29, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .fixedSize(horizontal: false, vertical: true)

                Text("Simpan profil latihan dan temukan pengaturan yang pas untuk perangkatmu.")
                    .font(.system(size: 13))
                    .foregroundStyle(Color.white.opacity(0.64))
                    .lineSpacing(4)

                HStack(spacing: 8) {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 9, weight: .bold))
                    Text("PREFERENSI DISIMPAN DI PERANGKAT")
                        .font(.system(size: 8, weight: .bold, design: .rounded))
                        .tracking(0.8)
                }
                .foregroundStyle(.white.opacity(0.58))
                .padding(.horizontal, 10)
                .padding(.vertical, 8)
                .background(.black.opacity(0.16), in: Capsule())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(21)
        .background(
            LinearGradient(
                colors: [Color(red: 0.10, green: 0.24, blue: 0.25), Color(red: 0.08, green: 0.11, blue: 0.18)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ),
            in: RoundedRectangle(cornerRadius: 24)
        )
        .overlay(RoundedRectangle(cornerRadius: 24).stroke(.white.opacity(0.08), lineWidth: 1))
    }

    private var profileCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("PILIH PROFIL")
                        .font(.system(size: 10, weight: .black, design: .rounded))
                        .tracking(1.4)
                        .foregroundStyle(.white)
                    Text("Mulai dari preset, lalu sesuaikan.")
                        .font(.system(size: 11))
                        .foregroundStyle(.white.opacity(0.48))
                }
                Spacer()
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(accent)
            }

            HStack(spacing: 8) {
                profileButton("Balanced", icon: "circle.lefthalf.filled", aim: 55, sensitivity: 75)
                profileButton("Precision", icon: "scope", aim: 38, sensitivity: 48)
                profileButton("Swift", icon: "bolt.fill", aim: 82, sensitivity: 90)
            }
        }
        .padding(16)
        .background(Color.white.opacity(0.045), in: RoundedRectangle(cornerRadius: 20))
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white.opacity(0.07), lineWidth: 1))
    }

    private func profileButton(_ title: String, icon: String, aim: Double, sensitivity: Double) -> some View {
        let isSelected = aimxProfile == title
        return Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                aimxProfile = title
                aimDragLevel = aim
                sensitivityLevel = sensitivity
            }
        } label: {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 15, weight: .semibold))
                Text(title.uppercased())
                    .font(.system(size: 8, weight: .black, design: .rounded))
                    .tracking(0.45)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
            }
            .foregroundStyle(isSelected ? Color(red: 0.035, green: 0.055, blue: 0.09) : .white.opacity(0.66))
            .frame(maxWidth: .infinity)
            .frame(height: 62)
            .background(isSelected ? accent : Color.white.opacity(0.045), in: RoundedRectangle(cornerRadius: 14))
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(isSelected ? accent : .white.opacity(0.07), lineWidth: 1))
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    private var tuningCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            sectionHeading("Kontrol latihan", subtitle: "Nilai tersimpan hanya di aplikasi ini.", icon: "slider.horizontal.3")

            VStack(spacing: 18) {
                sliderRow(
                    title: "Aim drag",
                    detail: "Profil feel latihan",
                    value: $aimDragLevel,
                    tint: accent
                )
                Rectangle().fill(.white.opacity(0.08)).frame(height: 1)
                VStack(alignment: .leading, spacing: 11) {
                    HStack(alignment: .firstTextBaseline) {
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Sensitivitas")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(.white)
                            Text("Preferensi pribadi")
                                .font(.system(size: 11))
                                .foregroundStyle(.white.opacity(0.48))
                        }
                        Spacer()
                        Text("\(Int(sensitivityLevel))%")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundStyle(accent)
                        Button("MAX") {
                            sensitivityLevel = 100
                        }
                        .font(.system(size: 10, weight: .black, design: .rounded))
                        .foregroundStyle(Color(red: 0.035, green: 0.055, blue: 0.09))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(accent, in: Capsule())
                        .accessibilityLabel("Atur preferensi sensitivitas ke maksimum")
                    }
                    Slider(value: $sensitivityLevel, in: 1...100, step: 1)
                        .tint(accent)
                }
            }
            .padding(16)
            .background(Color.white.opacity(0.045), in: RoundedRectangle(cornerRadius: 18))
            .overlay(RoundedRectangle(cornerRadius: 18).stroke(.white.opacity(0.06), lineWidth: 1))

            Text("Pengaturan ini tidak mengubah sensitivitas atau input di game/aplikasi lain.")
                .font(.system(size: 11))
                .foregroundStyle(.white.opacity(0.46))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(18)
        .panelStyle()
    }

    private var fpsCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            sectionHeading("Cek performa", subtitle: "Tips aman untuk menjaga FPS stabil.", icon: "speedometer")
            tipRow(number: "01", text: "Pilih preset grafis yang lebih ringan di dalam game.")
            tipRow(number: "02", text: "Tutup aplikasi yang tidak dipakai dan sisakan ruang penyimpanan.")
            tipRow(number: "03", text: "Hindari panas berlebih; lepas casing saat perangkat terasa panas.")
            Text("iOS tidak mengizinkan aplikasi pihak ketiga menaikkan FPS perangkat atau game lain secara langsung.")
                .font(.system(size: 11))
                .foregroundStyle(.white.opacity(0.46))
                .lineSpacing(3)
                .padding(.top, 2)
        }
        .padding(18)
        .panelStyle()
    }

    private var cleanerCard: some View {
        HStack(alignment: .top, spacing: 14) {
            Image(systemName: "sparkles")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(accent)
                .frame(width: 42, height: 42)
                .background(accent.opacity(0.12), in: RoundedRectangle(cornerRadius: 14))

            VStack(alignment: .leading, spacing: 7) {
                Text("Bersihkan cache AIMX")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
                Text("Hapus cache milik aplikasi ini saja. iOS melindungi file aplikasi lain.")
                    .font(.system(size: 11))
                    .foregroundStyle(.white.opacity(0.52))
                    .lineSpacing(3)
                Button {
                    let removedItems = CacheCleaner.clearAppCaches()
                    alertMessage = "Selesai. \(removedItems) item cache AIMX dihapus. File aplikasi lain tidak disentuh."
                    isShowingAlert = true
                } label: {
                    HStack(spacing: 7) {
                        Text("BERSIHKAN CACHE")
                        Image(systemName: "arrow.right")
                    }
                    .font(.system(size: 10, weight: .heavy, design: .rounded))
                    .tracking(0.8)
                    .foregroundStyle(accent)
                    .padding(.top, 4)
                }
                .buttonStyle(.plain)
            }
            Spacer(minLength: 0)
        }
        .padding(18)
        .panelStyle()
    }

    private var footer: some View {
        HStack(spacing: 6) {
            Image(systemName: "lock.shield")
            Text("Lokal • ringan • tanpa akses ke game lain")
        }
        .font(.system(size: 10, weight: .medium))
        .foregroundStyle(.white.opacity(0.38))
        .frame(maxWidth: .infinity)
        .padding(.top, 2)
    }

    private func sectionHeading(_ title: String, subtitle: String, icon: String) -> some View {
        HStack(spacing: 11) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(accent)
                .frame(width: 36, height: 36)
                .background(accent.opacity(0.10), in: RoundedRectangle(cornerRadius: 12))
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                Text(subtitle)
                    .font(.system(size: 11))
                    .foregroundStyle(.white.opacity(0.48))
            }
            Spacer(minLength: 0)
        }
    }

    private func sliderRow(title: String, detail: String, value: Binding<Double>, tint: Color) -> some View {
        VStack(alignment: .leading, spacing: 9) {
            HStack(alignment: .firstTextBaseline) {
                VStack(alignment: .leading, spacing: 3) {
                    Text(title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.white)
                    Text(detail)
                        .font(.system(size: 11))
                        .foregroundStyle(.white.opacity(0.48))
                }
                Spacer()
                Text("\(Int(value.wrappedValue))%")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(tint)
            }
            Slider(value: value, in: 0...100, step: 1)
                .tint(tint)
        }
    }

    private func tipRow(number: String, text: String) -> some View {
        HStack(alignment: .top, spacing: 11) {
            Text(number)
                .font(.system(size: 10, weight: .black, design: .rounded))
                .foregroundStyle(accent)
                .frame(width: 27, height: 27)
                .background(accent.opacity(0.10), in: RoundedRectangle(cornerRadius: 9))
            Text(text)
                .font(.system(size: 12))
                .foregroundStyle(.white.opacity(0.72))
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 4)
        }
    }
}

private extension View {
    func panelStyle() -> some View {
        background(Color(red: 0.075, green: 0.095, blue: 0.14), in: RoundedRectangle(cornerRadius: 22))
            .overlay(RoundedRectangle(cornerRadius: 22).stroke(.white.opacity(0.07), lineWidth: 1))
    }
}
