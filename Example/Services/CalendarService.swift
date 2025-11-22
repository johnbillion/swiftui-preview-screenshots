import Foundation

protocol CalendarService {
    func checkPermissionStatus() -> CalendarPermissionState
    func requestAccess() async -> Bool
}
