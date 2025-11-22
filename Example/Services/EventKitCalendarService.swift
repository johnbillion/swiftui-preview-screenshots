import EventKit

class EventKitCalendarService: CalendarService {
    private let eventStore = EKEventStore()

    func checkPermissionStatus() -> CalendarPermissionState {
        let status = EKEventStore.authorizationStatus(for: .event)

        switch status {
        case .notDetermined:
            return .notDetermined
        case .authorized, .fullAccess:
            return .authorized
        case .denied:
            return .denied
        case .restricted:
            return .restricted
        case .writeOnly:
            return .denied
        @unknown default:
            return .notDetermined
        }
    }

    func requestAccess() async -> Bool {
        do {
            return try await eventStore.requestFullAccessToEvents()
        } catch {
            return false
        }
    }
}
