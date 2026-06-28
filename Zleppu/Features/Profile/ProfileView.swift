import SwiftUI

struct ProfileView: View {
    @Environment(AuthState.self) private var auth

    var body: some View {
        NavigationStack {
            List {
                Section {
                    header
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                }

                Section {
                    proBadge
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                }

                Section {
                    ForEach(ProfileSetting.allCases) { setting in
                        NavigationLink {
                            SettingsDetailView(setting: setting)
                        } label: {
                            SettingsRow(icon: setting.icon, title: setting.title, showChevron: false)
                        }
                    }
                }

                Section {
                    Button("Log out") {
                        auth.signOut()
                    }
                    .foregroundStyle(ZleppuTheme.textSecondary)
                    .frame(maxWidth: .infinity)
                }
                .listRowBackground(Color.clear)
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(ZleppuTheme.background.ignoresSafeArea())
            .navigationTitle("Profile")
        }
    }

    private var header: some View {
        HStack(spacing: 16) {
            AvatarView(initials: auth.isGuest ? "G" : "A", size: 64)

            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Text(auth.displayName)
                        .font(.title2.bold())
                    if auth.isGuest {
                        Text("Guest")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(ZleppuTheme.slate)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(ZleppuTheme.lavender.opacity(0.6))
                            .clipShape(Capsule())
                    }
                }
                Text(auth.phoneNumber.isEmpty ? MockData.phoneNumber : auth.phoneNumber)
                    .font(.subheadline)
                    .foregroundStyle(ZleppuTheme.textSecondary)
            }

            Spacer()

            Image(systemName: "gearshape.fill")
                .foregroundStyle(ZleppuTheme.textSecondary)
        }
        .padding(20)
        .zleppuCard()
        .padding(.vertical, 4)
    }

    private var proBadge: some View {
        HStack {
            Image(systemName: auth.isGuest ? "person.fill.questionmark" : "crown.fill")
                .foregroundStyle(auth.isGuest ? ZleppuTheme.slate : ZleppuTheme.sunriseOrange)
            Text(auth.isGuest ? "Guest mode · demo data only" : "Pro Active")
                .font(.headline)
            Spacer()
        }
        .padding(18)
        .background((auth.isGuest ? ZleppuTheme.lavender : ZleppuTheme.peach).opacity(0.45))
        .clipShape(RoundedRectangle(cornerRadius: ZleppuTheme.cardRadius, style: .continuous))
        .padding(.vertical, 4)
    }
}

#Preview {
    ProfileView()
        .environment(AuthState().apply { $0.isLoggedIn = true; $0.isGuest = true })
        .environment(AppState())
}

private extension AuthState {
    func apply(_ configure: (AuthState) -> Void) -> AuthState {
        configure(self)
        return self
    }
}
