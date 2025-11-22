import SwiftUI

@main
struct ExampleApp: App {
    @State private var appState = AppState(calendarService: EventKitCalendarService())

    var body: some Scene {
        WindowGroup {
            ContentView(appState: appState)
        }
    }
}
