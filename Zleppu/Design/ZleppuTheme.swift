import SwiftUI

enum ZleppuTheme {
    static let navy = Color(hex: 0x22272E)
    static let slate = Color(hex: 0x2D3A4B)
    static let background = Color(hex: 0xF7F8FA)
    static let peach = Color(hex: 0xFFE6D3)
    static let sunriseOrange = Color(hex: 0xFF9B63)
    static let lavender = Color(hex: 0xD7D8FF)
    static let chatBlue = Color(hex: 0xD0DBFF)
    static let textPrimary = Color(hex: 0x22272E)
    static let textSecondary = Color(hex: 0x6B7280)
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
    var background: Color = ZleppuTheme.navy

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
