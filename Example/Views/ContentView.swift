import SwiftUI

struct ContentView: View {
    let appState: AppState
    let name: String

    init(appState: AppState, name: String = "World") {
        self.appState = appState
        self.name = name
    }

    var body: some View {
        switch appState.permissionState {
        case .notDetermined:
            PermissionPromptView(onrequestCalendarPermission: { appState.requestCalendarPermission() })
        case .denied, .restricted:
            PermissionDeniedView(onOpenSettings: { appState.openSystemSettings() })
        case .authorized:
            GreetingView(name: name)
        }
    }
}

#Preview("Permission Granted") {
    @Previewable @State var appState = AppState(calendarService: MockCalendarService(permissionState: .authorized))
    ContentView(appState: appState)
        .frame(width: 400, height: 300)
}

#Preview("Permission Not Determined") {
    @Previewable @State var appState = AppState(calendarService: MockCalendarService(permissionState: .notDetermined))
    ContentView(appState: appState)
        .frame(width: 400, height: 300)
}

#Preview("Permission Denied") {
    @Previewable @State var appState = AppState(calendarService: MockCalendarService(permissionState: .denied))
    ContentView(appState: appState)
        .frame(width: 400, height: 300)
}

#Preview("Permission Restricted") {
    @Previewable @State var appState = AppState(calendarService: MockCalendarService(permissionState: .restricted))
    ContentView(appState: appState)
        .frame(width: 400, height: 300)
}
