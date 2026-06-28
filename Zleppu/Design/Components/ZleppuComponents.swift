import SwiftUI

struct ZleppuLogo: View {
    var size: CGFloat = 64
    var light: Bool = false

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [ZleppuTheme.sunriseOrange, ZleppuTheme.peach],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: size, height: size)

                Image(systemName: "sun.max.fill")
                    .font(.system(size: size * 0.42))
                    .foregroundStyle(.white)
                    .offset(y: -2)
            }

            Text("zleppu")
                .font(.system(size: size * 0.45, weight: .semibold, design: .rounded))
                .foregroundStyle(light ? .white : ZleppuTheme.textPrimary)
                .tracking(0.5)
        }
    }
}

struct SunriseBackground: View {
    var blur: Bool = false
    var dim: Double = 0

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(hex: 0xFFD4A8),
                    Color(hex: 0xFF9B63),
                    Color(hex: 0xE8875A),
                    Color(hex: 0x6B8FA8),
                    Color(hex: 0x2D3A4B)
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            RadialGradient(
                colors: [.white.opacity(0.45), .clear],
                center: .init(x: 0.5, y: 0.18),
                startRadius: 10,
                endRadius: 220
            )
        }
        .blur(radius: blur ? 12 : 0)
        .overlay(Color.black.opacity(dim))
        .ignoresSafeArea()
    }
}

struct AvatarView: View {
    let initials: String
    var color: Color = ZleppuTheme.lavender
    var size: CGFloat = 36

    var body: some View {
        Text(initials)
            .font(.system(size: size * 0.34, weight: .semibold))
            .foregroundStyle(ZleppuTheme.slate)
            .frame(width: size, height: size)
            .background(color)
            .clipShape(Circle())
    }
}

struct AvatarStack: View {
    let initials: [String]
    var size: CGFloat = 28

    var body: some View {
        HStack(spacing: -8) {
            ForEach(Array(initials.enumerated()), id: \.offset) { index, initial in
                AvatarView(
                    initials: initial,
                    color: avatarColor(for: index),
                    size: size
                )
                .overlay(Circle().strokeBorder(.white, lineWidth: 2))
            }
        }
    }

    private func avatarColor(for index: Int) -> Color {
        [ZleppuTheme.lavender, ZleppuTheme.peach, ZleppuTheme.chatBlue][index % 3]
    }
}

struct StatCard: View {
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 6) {
            Text(value)
                .font(.title2.bold())
                .foregroundStyle(ZleppuTheme.textPrimary)
            Text(label)
                .font(.caption)
                .foregroundStyle(ZleppuTheme.textSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .zleppuCard()
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.body)
                .foregroundStyle(ZleppuTheme.slate)
                .frame(width: 24)

            Text(title)
                .font(.body)
                .foregroundStyle(ZleppuTheme.textPrimary)

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(ZleppuTheme.textSecondary)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 16)
    }
}
