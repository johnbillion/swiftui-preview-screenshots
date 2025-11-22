import Foundation

class MockCalendarService: CalendarService {
    var permissionState: CalendarPermissionState
    var shouldGrantAccess: Bool

    init(permissionState: CalendarPermissionState = .notDetermined, shouldGrantAccess: Bool = true) {
        self.permissionState = permissionState
        self.shouldGrantAccess = shouldGrantAccess
    }

    func checkPermissionStatus() -> CalendarPermissionState {
        return permissionState
    }

    func requestAccess() async -> Bool {
        if shouldGrantAccess {
            permissionState = .authorized
        }
        return shouldGrantAccess
    }
}
