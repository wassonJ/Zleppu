import SwiftUI

struct GreetingHeader: View {
    let name: String

    var body: some View {
        HStack(spacing: 6) {
            Text("Good morning, \(name)")
                .font(.title2.bold())
                .foregroundStyle(ZleppuTheme.textPrimary)
            SunAccentIcon(size: 20)
        }
    }
}
