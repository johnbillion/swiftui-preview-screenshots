import SwiftUI

struct GreetingView: View {
    let name: String

    init(name: String = "World") {
        self.name = name
    }

    var body: some View {
        Text("Hello, \(name)!", comment: "Greeting message shown to user")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
    }
}

#Preview("Default") {
    GreetingView()
        .frame(width: 400, height: 300)
}

#Preview("Alice") {
    GreetingView(name: "Alice")
        .frame(width: 400, height: 300)
}

#Preview("Bob") {
    GreetingView(name: "Bob")
        .frame(width: 400, height: 300)
}

#Preview("German") {
    GreetingView(name: "Welt")
        .environment(\.locale, Locale(identifier: "de"))
        .frame(width: 400, height: 300)
}

#Preview("Arabic") {
    GreetingView(name: "العالم")
        .environment(\.locale, Locale(identifier: "ar"))
        .environment(\.layoutDirection, .rightToLeft)
        .frame(width: 400, height: 300)
}

#Preview("Dark Mode") {
    GreetingView()
        .frame(width: 400, height: 300)
        .preferredColorScheme(.dark)
}
