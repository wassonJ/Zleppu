import SwiftUI

struct ApproveAlarmView: View {
    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    AvatarView(initials: "M", size: 56)
                    Text("Maja wants to set an alarm for the room")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(ZleppuTheme.textPrimary)
                }
                .padding(.top, 12)

                VStack(spacing: 4) {
                    Text("07:00")
                        .font(.system(size: 52, weight: .bold, design: .rounded))
                    Text("Tomorrow · Fri, 25 Oct")
                        .font(.subheadline)
                        .foregroundStyle(ZleppuTheme.textSecondary)
                }

                VStack(spacing: 0) {
                    detailRow(label: "Room", value: appState.selectedRoom.name)
                    Divider().padding(.leading, 18)
                    detailRow(label: "Repeat", value: "Weekdays")
                    Divider().padding(.leading, 18)
                    detailRow(label: "Sound", value: "Sunrise")
                }
                .zleppuCard()

                Spacer()

                VStack(spacing: 12) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Approve", systemImage: "checkmark")
                            .font(.headline)
                            .foregroundStyle(ZleppuTheme.slate)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(ZleppuTheme.lavender)
                            .clipShape(Capsule())
                    }

                    Button("Decline") {
                        dismiss()
                    }
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(ZleppuTheme.textSecondary)
                }
            }
            .padding(24)
            .background(ZleppuTheme.background.ignoresSafeArea())
            .navigationTitle("Approve alarm")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func detailRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .foregroundStyle(ZleppuTheme.textSecondary)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
                .foregroundStyle(ZleppuTheme.textPrimary)
        }
        .font(.subheadline)
        .padding(.horizontal, 18)
        .padding(.vertical, 14)
    }
}

#Preview {
    ApproveAlarmView()
        .environment(AppState())
}
