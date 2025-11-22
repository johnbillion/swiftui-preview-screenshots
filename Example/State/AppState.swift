import SwiftUI

@MainActor
@Observable
class AppState {
    private let calendarService: CalendarService

    var permissionState: CalendarPermissionState

    init(calendarService: CalendarService) {
        self.calendarService = calendarService
        self.permissionState = calendarService.checkPermissionStatus()
    }

    func requestCalendarPermission() {
        Task {
            let granted = await calendarService.requestAccess()
            self.permissionState = granted ? .authorized : .denied
        }
    }

    func openSystemSettings() {
        if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Calendars") {
            NSWorkspace.shared.open(url)
        }
    }
}
