import SwiftUI

struct MorningSummaryView: View {
    @Environment(\.dismiss) private var dismiss

    private let members = [
        ("Maja", "M", true),
        ("Viktor", "V", true),
        ("You", "A", true)
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Morning summary")
                        .font(.largeTitle.bold())
                    Text("Today")
                        .font(.subheadline)
                        .foregroundStyle(ZleppuTheme.textSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Morning Crew")
                            .font(.headline)
                        Spacer()
                        Text("07:00")
                            .font(.headline)
                            .foregroundStyle(ZleppuTheme.purpleLight)
                    }

                    ForEach(members, id: \.0) { member in
                        HStack(spacing: 12) {
                            AvatarView(initials: member.1, size: 40)
                            Text(member.0)
                                .font(.body)
                            Spacer()
                            if member.2 {
                                Label("Answered", systemImage: "checkmark.circle.fill")
                                    .font(.caption.weight(.semibold))
                                    .foregroundStyle(.green)
                            }
                        }
                    }
                }
                .padding(20)
                .zleppuCard()

                Spacer()

                VStack(spacing: 8) {
                    HStack(spacing: 6) {
                        Text("Great start!")
                            .font(.title2.bold())
                        SunAccentIcon(size: 22)
                    }
                    Text("You woke up together.")
                        .font(.body)
                        .foregroundStyle(ZleppuTheme.textSecondary)
                }
                .multilineTextAlignment(.center)
                .padding(.bottom, 24)
            }
            .padding(24)
            .background(ZleppuTheme.background.ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    MorningSummaryView()
}
