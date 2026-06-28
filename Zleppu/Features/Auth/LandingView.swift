import SwiftUI

struct LandingView: View {
    @Environment(AuthState.self) private var auth

    var body: some View {
        ZStack {
            SunriseBackground()

            VStack {
                Spacer()

                ZleppuLogo(size: 120, light: true, showWordmark: true)

                Text("Wake up together.\nStay consistent.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white.opacity(0.92))
                    .padding(.top, 16)

                Spacer()

                VStack(spacing: 14) {
                    Button("Continue as guest") {
                        auth.loginAsGuest()
                    }
                    .buttonStyle(ZleppuPrimaryButtonStyle())

                    Button("Create account") {
                        auth.showLogin = true
                    }
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(.white.opacity(0.18))
                    .clipShape(Capsule())

                    Button("Log in") {
                        auth.showLogin = true
                    }
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.white.opacity(0.9))
                }
                .padding(.horizontal, 28)
                .padding(.bottom, 48)
            }
        }
    }
}

#Preview {
    LandingView()
        .environment(AuthState())
}
