import SwiftUI

struct ChatView: View {
    let room: Room
    @Environment(AppState.self) private var appState
    @State private var messageText = ""

    var body: some View {
        VStack(spacing: 0) {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(messagesForRoom) { message in
                            messageBubble(message)
                                .id(message.id)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
                .onAppear {
                    if let last = messagesForRoom.last {
                        proxy.scrollTo(last.id, anchor: .bottom)
                    }
                }
            }

            inputBar
        }
        .background(ZleppuTheme.background.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button("Start wake-up call") {
                        appState.showIncomingCall = true
                    }
                    Button("Propose alarm") {
                        appState.selectedRoom = room
                        appState.showApproveAlarm = true
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }

            ToolbarItem(placement: .principal) {
                VStack(spacing: 2) {
                    Text(room.name)
                        .font(.headline)
                    Text("\(room.onlineCount) online")
                        .font(.caption2)
                        .foregroundStyle(ZleppuTheme.textSecondary)
                }
            }
        }
    }

    private var messagesForRoom: [ChatMessage] {
        room.id == MockData.mainRoom.id ? MockData.messages : [
            ChatMessage(sender: "System", text: "Welcome to \(room.name).", time: "08:00", isMine: false, read: true)
        ]
    }

    private func messageBubble(_ message: ChatMessage) -> some View {
        HStack {
            if message.isMine { Spacer(minLength: 48) }

            VStack(alignment: message.isMine ? .trailing : .leading, spacing: 4) {
                if !message.isMine {
                    Text(message.sender)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(ZleppuTheme.textSecondary)
                }

                Text(message.text)
                    .font(.body)
                    .foregroundStyle(message.isMine ? ZleppuTheme.slate : ZleppuTheme.textPrimary)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(message.isMine ? ZleppuTheme.chatBlue : ZleppuTheme.surface)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .shadow(color: ZleppuTheme.shadow, radius: 4, y: 2)

                HStack(spacing: 4) {
                    Text(message.time)
                    if message.isMine {
                        Image(systemName: message.read ? "checkmark.circle.fill" : "checkmark.circle")
                    }
                }
                .font(.caption2)
                .foregroundStyle(ZleppuTheme.textSecondary)
            }

            if !message.isMine { Spacer(minLength: 48) }
        }
    }

    private var inputBar: some View {
        HStack(spacing: 10) {
            Button {} label: {
                Image(systemName: "plus")
                    .font(.body.weight(.semibold))
                    .foregroundStyle(ZleppuTheme.slate)
                    .frame(width: 36, height: 36)
                    .background(ZleppuTheme.surface)
                    .clipShape(Circle())
            }

            TextField("Write a message...", text: $messageText)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(ZleppuTheme.surface)
                .clipShape(Capsule())

            Button {} label: {
                Image(systemName: "arrow.up")
                    .font(.body.weight(.bold))
                    .foregroundStyle(.white)
                    .frame(width: 36, height: 36)
                    .background(ZleppuTheme.slate)
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(ZleppuTheme.background)
    }
}

#Preview {
    NavigationStack {
        ChatView(room: MockData.mainRoom)
    }
    .environment(AppState())
}
