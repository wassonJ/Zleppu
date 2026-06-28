import SwiftUI

struct RoomsListView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(MockData.rooms) { room in
                        NavigationLink(value: room) {
                            roomRow(room)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(20)
            }
            .background(ZleppuTheme.background.ignoresSafeArea())
            .navigationTitle("Rooms")
            .navigationDestination(for: Room.self) { room in
                ChatView(room: room)
            }
        }
    }

    private func roomRow(_ room: Room) -> some View {
        HStack(spacing: 14) {
            AvatarStack(initials: room.memberInitials, size: 32)

            VStack(alignment: .leading, spacing: 4) {
                Text(room.name)
                    .font(.headline)
                    .foregroundStyle(ZleppuTheme.textPrimary)
                Text("\(room.onlineCount) online")
                    .font(.caption)
                    .foregroundStyle(ZleppuTheme.textSecondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(ZleppuTheme.textSecondary)
        }
        .padding(18)
        .zleppuCard()
    }
}

#Preview {
    RoomsListView()
}
