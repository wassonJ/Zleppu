import SwiftUI

struct RootView: View {
    @Environment(AuthState.self) private var auth

    var body: some View {
        Group {
            if auth.isLoggedIn {
                MainTabView()
            } else if auth.showLogin {
                PhoneLoginView()
            } else {
                LandingView()
            }
        }
        .animation(.easeInOut(duration: 0.25), value: auth.isLoggedIn)
        .animation(.easeInOut(duration: 0.25), value: auth.showLogin)
    }
}

#Preview {
    RootView()
        .environment(AuthState())
        .environment(AppState())
}
