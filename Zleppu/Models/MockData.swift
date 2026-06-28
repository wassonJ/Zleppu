import Foundation

struct Room: Identifiable, Hashable {
    let id: UUID
    let name: String
    let memberInitials: [String]
    let onlineCount: Int
}

struct ChatMessage: Identifiable {
    let id = UUID()
    let sender: String
    let text: String
    let time: String
    let isMine: Bool
    let read: Bool
}

struct UpcomingAlarm: Identifiable {
    let id = UUID()
    let roomName: String
    let time: String
    let subtitle: String
}

enum MockData {
    static let displayName = "Alex"
    static let phoneNumber = "+46 70 123 45 67"

    static let mainRoom = Room(
        id: UUID(),
        name: "Morning Crew",
        memberInitials: ["M", "V", "A"],
        onlineCount: 3
    )

    static let rooms: [Room] = [
        mainRoom,
        Room(id: UUID(), name: "Family", memberInitials: ["E", "L"], onlineCount: 1),
        Room(id: UUID(), name: "Study Group", memberInitials: ["S", "K", "J"], onlineCount: 2)
    ]

    static let messages: [ChatMessage] = [
        ChatMessage(sender: "Maja", text: "Tomorrow 07:00 — is everyone in?", time: "21:14", isMine: false, read: true),
        ChatMessage(sender: "You", text: "I'm in!", time: "21:16", isMine: true, read: true),
        ChatMessage(sender: "Viktor", text: "Same here. Call or just text?", time: "21:18", isMine: false, read: true),
        ChatMessage(sender: "You", text: "A call would be nice tomorrow", time: "21:19", isMine: true, read: false)
    ]

    static let upcoming: [UpcomingAlarm] = [
        UpcomingAlarm(roomName: "Morning Crew", time: "07:00", subtitle: "Tomorrow · Weekdays"),
        UpcomingAlarm(roomName: "Family", time: "08:30", subtitle: "Sunday"),
        UpcomingAlarm(roomName: "Study Group", time: "06:45", subtitle: "Monday")
    ]
}
