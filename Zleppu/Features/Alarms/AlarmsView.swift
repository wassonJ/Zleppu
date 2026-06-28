import SwiftUI

struct AlarmsView: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    alarmCard(
                        time: "07:00",
                        title: "Morning Crew",
                        subtitle: "Tomorrow · Weekdays",
                        members: ["M", "V", "A"]
                    )

                    alarmCard(
                        time: "08:30",
                        title: "Family",
                        subtitle: "Sunday · One time",
                        members: ["E", "L"]
                    )

                    Button {
                        appState.showApproveAlarm = true
                    } label: {
                        Label("Review pending request", systemImage: "bell.badge")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(ZleppuTheme.slate)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .zleppuCard()
                    }
                    .buttonStyle(.plain)
                }
                .padding(20)
            }
            .background(ZleppuTheme.background.ignoresSafeArea())
            .navigationTitle("Alarms")
        }
    }

    private func alarmCard(time: String, title: String, subtitle: String, members: [String]) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top) {
                Text(time)
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                Spacer()
                Image(systemName: "moon.stars.fill")
                    .foregroundStyle(ZleppuTheme.purpleLight)
            }

            Text(title)
                .font(.headline)

            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(ZleppuTheme.textSecondary)

            AvatarStack(initials: members)
        }
        .foregroundStyle(ZleppuTheme.textPrimary)
        .padding(20)
        .zleppuCard()
    }
}

#Preview {
    AlarmsView()
        .environment(AppState())
}
