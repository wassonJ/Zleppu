import SwiftUI

struct ZleppuLogo: View {
    var size: CGFloat = 64
    var light: Bool = false
    var showWordmark: Bool = true

    var body: some View {
        VStack(spacing: 10) {
            Image("AppLogo")
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: size * 0.22, style: .continuous))
                .shadow(color: .black.opacity(light ? 0.15 : 0.08), radius: 8, y: 4)

            if showWordmark {
                Text("zleppu")
                    .font(.system(size: size * 0.38, weight: .semibold, design: .rounded))
                    .foregroundStyle(light ? .white : ZleppuTheme.textPrimary)
                    .tracking(0.5)
            }
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
                    ZleppuTheme.cream,
                    Color(hex: 0xE8E2F8),
                    ZleppuTheme.purpleLight,
                    ZleppuTheme.purple,
                    Color(hex: 0x1E1A55)
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            RadialGradient(
                colors: [Color.white.opacity(0.35), .clear],
                center: .init(x: 0.5, y: 0.15),
                startRadius: 10,
                endRadius: 240
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
            .foregroundStyle(ZleppuTheme.purple)
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
    var showChevron: Bool = true

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.body)
                .foregroundStyle(ZleppuTheme.purple)
                .frame(width: 24)

            Text(title)
                .font(.body)
                .foregroundStyle(ZleppuTheme.textPrimary)

            Spacer()

            if showChevron {
                Image(systemName: "chevron.right")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(ZleppuTheme.textSecondary)
            }
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 4)
    }
}
