import SwiftUI

struct PermissionPromptView: View {
    let onrequestCalendarPermission: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Calendar Access Required", comment: "Title for calendar permission prompt")
                .font(.title)

            Text("This app needs access to your calendars to display and manage your events.", comment: "Description for calendar permission prompt")
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button(action: onrequestCalendarPermission) {
                Text("Grant Access", comment: "Button to request calendar permission")
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

#Preview("Prompt") {
    PermissionPromptView(onrequestCalendarPermission: {})
        .frame(width: 400, height: 300)
}
