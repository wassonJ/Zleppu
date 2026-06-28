import SwiftUI

@main
struct ZleppuApp: App {
    @State private var auth = AuthState()
    @State private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(auth)
                .environment(appState)
        }
    }
}
