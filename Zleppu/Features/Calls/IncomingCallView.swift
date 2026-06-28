import SwiftUI

struct IncomingCallView: View {
    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss

    private let quickReplies = [
        "I'm awake!",
        "Give me 5 min",
        "Can't talk now",
        "Text you later"
    ]

    var body: some View {
        ZStack {
            SunriseBackground(blur: true, dim: 0.35)

            VStack(spacing: 28) {
                VStack(spacing: 8) {
                    Text("INCOMING WAKE-UP CALL")
                        .font(.caption.weight(.bold))
                        .tracking(1.2)
                        .foregroundStyle(.white.opacity(0.85))

                    Text(MockData.mainRoom.name)
                        .font(.title.bold())
                        .foregroundStyle(.white)

                    Text("Maja is calling you")
                        .font(.title3)
                        .foregroundStyle(.white.opacity(0.9))
                }
                .padding(.top, 48)

                Spacer()

                ZStack {
                    Circle()
                        .stroke(.white.opacity(0.25), lineWidth: 2)
                        .frame(width: 140, height: 140)
                    Circle()
                        .stroke(.white.opacity(0.15), lineWidth: 2)
                        .frame(width: 180, height: 180)
                    Circle()
                        .fill(.white.opacity(0.15))
                        .frame(width: 96, height: 96)
                        .overlay {
                            Image(systemName: "phone.fill")
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                        }
                }

                Spacer()

                HStack(spacing: 56) {
                    callButton(icon: "xmark", label: "Decline", color: ZleppuTheme.danger) {
                        dismiss()
                    }

                    callButton(icon: "phone.fill", label: "Accept", color: .green) {
                        dismiss()
                        appState.showActiveCall = true
                    }
                }

                VStack(spacing: 10) {
                    ForEach(quickReplies, id: \.self) { reply in
                        Button(reply) {
                            dismiss()
                        }
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(.white.opacity(0.15))
                        .clipShape(Capsule())
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
            }
        }
    }

    private func callButton(icon: String, label: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(.white)
                    .frame(width: 68, height: 68)
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
    IncomingCallView()
        .environment(AppState())
}
