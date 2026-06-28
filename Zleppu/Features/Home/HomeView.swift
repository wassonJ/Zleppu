import SwiftUI

struct HomeView: View {
    @Environment(AuthState.self) private var auth
    @Environment(AppState.self) private var appState

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    header

                    nextWakeUpCard

                    progressSection

                    upcomingSection
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
            .background(ZleppuTheme.background.ignoresSafeArea())
            .navigationBarHidden(true)
            .navigationDestination(for: Room.self) { room in
                ChatView(room: room)
            }
        }
    }

    private var header: some View {
        HStack(alignment: .top) {
            GreetingHeader(name: auth.displayName)

            Spacer()

            Button {
                appState.showIncomingCall = true
            } label: {
                Image(systemName: "bell.fill")
                    .font(.body)
                    .foregroundStyle(ZleppuTheme.slate)
                    .frame(width: 44, height: 44)
                    .background(ZleppuTheme.surface)
                    .clipShape(Circle())
                    .shadow(color: ZleppuTheme.shadow, radius: 8, y: 2)
            }
        }
        .padding(.top, 8)
    }

    private var nextWakeUpCard: some View {
        NavigationLink(value: MockData.mainRoom) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Next wake up")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(ZleppuTheme.textSecondary)

                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("07:00")
                            .font(.system(size: 44, weight: .bold, design: .rounded))
                            .foregroundStyle(ZleppuTheme.textPrimary)

                        Text("Tomorrow")
                            .font(.headline)
                            .foregroundStyle(ZleppuTheme.textSecondary)
                    }

                    Spacer()

                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [ZleppuTheme.sunriseOrange, ZleppuTheme.peach],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 72, height: 72)
                        .overlay {
                            Image(systemName: "sun.horizon.fill")
                                .font(.title2)
                                .foregroundStyle(.white)
                        }
                }

                HStack {
                    AvatarStack(initials: MockData.mainRoom.memberInitials)
                    Text(MockData.mainRoom.name)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(ZleppuTheme.textPrimary)
                    Spacer()
                }
            }
            .padding(20)
            .zleppuCard()
        }
        .buttonStyle(.plain)
    }

    private var progressSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Today's progress")
                .font(.headline)
                .foregroundStyle(ZleppuTheme.textPrimary)

            HStack(spacing: 12) {
                StatCard(value: "2", label: "Alarms set")
                StatCard(value: "1", label: "Call answered")
                StatCard(value: "0", label: "Snoozed")
            }
        }
    }

    private var upcomingSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Upcoming")
                .font(.headline)
                .foregroundStyle(ZleppuTheme.textPrimary)

            VStack(spacing: 10) {
                ForEach(MockData.upcoming) { alarm in
                    upcomingRow(alarm)
                }
            }
        }
    }

    private func upcomingRow(_ alarm: UpcomingAlarm) -> some View {
        Button {
            if let room = MockData.rooms.first(where: { $0.name == alarm.roomName }) {
                appState.selectedRoom = room
            }
            appState.showApproveAlarm = true
        } label: {
            HStack(spacing: 14) {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(ZleppuTheme.peach.opacity(0.7))
                    .frame(width: 48, height: 48)
                    .overlay {
                        Image(systemName: "alarm.fill")
                            .foregroundStyle(ZleppuTheme.sunriseOrange)
                    }

                VStack(alignment: .leading, spacing: 4) {
                    Text(alarm.roomName)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(ZleppuTheme.textPrimary)
                    Text(alarm.subtitle)
                        .font(.caption)
                        .foregroundStyle(ZleppuTheme.textSecondary)
                }

                Spacer()

                Text(alarm.time)
                    .font(.headline)
                    .foregroundStyle(ZleppuTheme.textPrimary)
            }
            .padding(14)
            .zleppuCard()
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HomeView()
        .environment(AuthState().apply { $0.isLoggedIn = true; $0.displayName = "Alex" })
        .environment(AppState())
}

private extension AuthState {
    func apply(_ configure: (AuthState) -> Void) -> AuthState {
        configure(self)
        return self
    }
}
