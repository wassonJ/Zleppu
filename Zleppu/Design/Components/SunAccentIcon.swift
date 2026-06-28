import SwiftUI

struct SunAccentIcon: View {
    var size: CGFloat = 18

    var body: some View {
        Image(systemName: "moon.stars.fill")
            .font(.system(size: size))
            .foregroundStyle(ZleppuTheme.purpleLight)
    }
}

struct GreetingHeader: View {
    let name: String

    var body: some View {
        HStack(spacing: 6) {
            Text("Good morning, \(name)")
                .font(.title2.bold())
                .foregroundStyle(ZleppuTheme.textPrimary)
            SunAccentIcon(size: 18)
        }
    }
}
