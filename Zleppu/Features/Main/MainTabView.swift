import SwiftUI

struct MainTabView: View {
    @Environment(AppState.self) private var appState

    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)

            RoomsListView()
                .tabItem { Label("Rooms", systemImage: "person.3.fill") }
                .tag(1)

            Color.clear
                .tabItem { Label("Add", systemImage: "plus.circle.fill") }
                .tag(2)

            AlarmsView()
                .tabItem { Label("Alarms", systemImage: "alarm.fill") }
                .tag(3)

            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }
                .tag(4)
        }
        .tint(ZleppuTheme.slate)
        .onChange(of: selectedTab) { _, newValue in
            if newValue == 2 {
                selectedTab = 0
            }
        }
        .fullScreenCover(isPresented: Bindable(appState).showIncomingCall) {
            IncomingCallView()
        }
        .fullScreenCover(isPresented: Bindable(appState).showActiveCall) {
            ActiveCallView()
        }
        .fullScreenCover(isPresented: Bindable(appState).showMorningSummary) {
            MorningSummaryView()
        }
        .sheet(isPresented: Bindable(appState).showApproveAlarm) {
            ApproveAlarmView()
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    MainTabView()
        .environment(AuthState().apply { $0.isLoggedIn = true })
        .environment(AppState())
}

private extension AuthState {
    func apply(_ configure: (AuthState) -> Void) -> AuthState {
        configure(self)
        return self
    }
}
