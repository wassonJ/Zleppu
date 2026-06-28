import SwiftUI

enum ZleppuTheme {
    // Logo purple palette
    static let purple = Color(hex: 0x2E2980)
    static let purpleLight = Color(hex: 0x5B52A8)
    static let purpleSoft = Color(hex: 0x8B82C9)
    static let cream = Color(hex: 0xFFF5E6)

    static let navy = Color(hex: 0x2E2980)
    static let slate = Color(hex: 0x4A4585)
    static let background = Color(hex: 0xFAF8F5)
    static let peach = Color(hex: 0xEDE8F5)
    static let sunriseOrange = Color(hex: 0x5B52A8)
    static let lavender = Color(hex: 0xD4CCF0)
    static let chatBlue = Color(hex: 0xE4E0F5)
    static let textPrimary = Color(hex: 0x2A2640)
    static let textSecondary = Color(hex: 0x6B667A)
    static let surface = Color.white
    static let danger = Color(hex: 0xFF6B6B)

    static let cardRadius: CGFloat = 20
    static let buttonRadius: CGFloat = 28
    static let shadow = Color.black.opacity(0.06)
}

extension Color {
    init(hex: UInt, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: opacity
        )
    }
}

struct ZleppuPrimaryButtonStyle: ButtonStyle {
    var background: Color = ZleppuTheme.purple

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(background.opacity(configuration.isPressed ? 0.88 : 1))
            .clipShape(Capsule())
    }
}

struct ZleppuSoftCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(ZleppuTheme.surface)
            .clipShape(RoundedRectangle(cornerRadius: ZleppuTheme.cardRadius, style: .continuous))
            .shadow(color: ZleppuTheme.shadow, radius: 12, y: 4)
    }
}

extension View {
    func zleppuCard() -> some View {
        modifier(ZleppuSoftCard())
    }
}
