import SwiftUI

struct ActiveCallView: View {
    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss
    @State private var elapsed = 24

    var body: some View {
        ZStack {
            SunriseBackground(dim: 0.45)

            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Text("WAKE-UP CALL")
                        .font(.caption.weight(.bold))
                        .tracking(1.2)
                        .foregroundStyle(.white.opacity(0.85))

                    Text(MockData.mainRoom.name)
                        .font(.title.bold())
                        .foregroundStyle(.white)

                    Text(formattedTime)
                        .font(.system(size: 48, weight: .light, design: .rounded))
                        .monospacedDigit()
                        .foregroundStyle(.white)

                    Text("Maja, Viktor")
                        .font(.title3)
                        .foregroundStyle(.white.opacity(0.85))
                }
                .padding(.top, 72)

                Spacer()

                HStack(spacing: 36) {
                    controlButton(icon: "mic.slash.fill", label: "Mute") {}
                    controlButton(icon: "phone.down.fill", label: "End call", color: ZleppuTheme.danger) {
                        dismiss()
                        appState.showMorningSummary = true
                    }
                    controlButton(icon: "speaker.wave.2.fill", label: "Speaker") {}
                }
                .padding(.bottom, 56)
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                elapsed += 1
            }
        }
    }

    private var formattedTime: String {
        let minutes = elapsed / 60
        let seconds = elapsed % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    private func controlButton(
        icon: String,
        label: String,
        color: Color = .white.opacity(0.2),
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundStyle(.white)
                    .frame(width: 64, height: 64)
                    .background(color)
                    .clipShape(Circle())
                Text(label)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.9))
            }
        }
    }
}

#Preview {
    ActiveCallView()
        .environment(AppState())
}
