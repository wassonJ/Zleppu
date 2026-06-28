import SwiftUI

enum ProfileSetting: String, Identifiable, CaseIterable, Hashable {
    case notifications
    case alarmSettings
    case privacy
    case blockedUsers
    case help
    case about

    var id: String { rawValue }

    var title: String {
        switch self {
        case .notifications: "Notifications"
        case .alarmSettings: "Alarm settings"
        case .privacy: "Privacy & security"
        case .blockedUsers: "Blocked users"
        case .help: "Help & support"
        case .about: "About Zleppu"
        }
    }

    var icon: String {
        switch self {
        case .notifications: "bell.fill"
        case .alarmSettings: "alarm.fill"
        case .privacy: "lock.fill"
        case .blockedUsers: "hand.raised.fill"
        case .help: "questionmark.circle.fill"
        case .about: "info.circle.fill"
        }
    }
}

struct SettingsDetailView: View {
    let setting: ProfileSetting

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                switch setting {
                case .notifications:
                    settingsSection(
                        title: "Push notifications",
                        body: "Get notified when someone calls, proposes an alarm, or messages you in your rooms."
                    )
                    toggleRow(title: "Wake-up calls", isOn: true)
                    toggleRow(title: "Alarm requests", isOn: true)
                    toggleRow(title: "New messages", isOn: true)
                    toggleRow(title: "Morning summary", isOn: false)

                case .alarmSettings:
                    settingsSection(
                        title: "Your alarms",
                        body: "Every alarm must be approved by you before it becomes active."
                    )
                    infoRow(label: "Default sound", value: "Sunrise")
                    infoRow(label: "Buffer", value: "5 min before & after")
                    infoRow(label: "Snooze", value: "Off (demo)")

                case .privacy:
                    settingsSection(
                        title: "Private by design",
                        body: "No public profiles, no photos, and no discovery features."
                    )
                    infoRow(label: "Phone number", value: "Verified")
                    infoRow(label: "Face ID", value: "Not enabled")
                    infoRow(label: "Screenshots", value: "Not blocked")

                case .blockedUsers:
                    settingsSection(
                        title: "Blocked",
                        body: "Blocked people cannot message, call, or invite you."
                    )
                    Text("No blocked users in demo mode.")
                        .font(.subheadline)
                        .foregroundStyle(ZleppuTheme.textSecondary)
                        .padding(18)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .zleppuCard()

                case .help:
                    settingsSection(
                        title: "Need help?",
                        body: "Zleppu helps you wake up together with people you trust."
                    )
                    demoLinkRow(title: "FAQ")
                    demoLinkRow(title: "Report a problem")
                    demoLinkRow(title: "Contact support")

                case .about:
                    settingsSection(
                        title: "Zleppu",
                        body: "Wake up together. Stay consistent."
                    )
                    infoRow(label: "Version", value: "0.1.0 (demo)")
                    infoRow(label: "Language", value: "English")
                    Text("Zleppu is not social media. The app exists to help you live better outside the screen.")
                        .font(.footnote)
                        .foregroundStyle(ZleppuTheme.textSecondary)
                }
            }
            .padding(20)
        }
        .background(ZleppuTheme.background.ignoresSafeArea())
        .navigationTitle(setting.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func settingsSection(title: String, body: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            Text(body)
                .font(.subheadline)
                .foregroundStyle(ZleppuTheme.textSecondary)
        }
    }

    private func toggleRow(title: String, isOn: Bool) -> some View {
        HStack {
            Text(title)
                .font(.body)
            Spacer()
            Toggle("", isOn: .constant(isOn))
                .labelsHidden()
        }
        .padding(18)
        .zleppuCard()
    }

    private func infoRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .foregroundStyle(ZleppuTheme.textSecondary)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
        }
        .font(.subheadline)
        .padding(18)
        .zleppuCard()
    }

    private func demoLinkRow(title: String) -> some View {
        Button {} label: {
            HStack {
                Text(title)
                    .foregroundStyle(ZleppuTheme.textPrimary)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(ZleppuTheme.textSecondary)
            }
            .font(.body)
            .padding(18)
            .zleppuCard()
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        SettingsDetailView(setting: .notifications)
    }
}
