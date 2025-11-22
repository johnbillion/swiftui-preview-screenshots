import SwiftUI

struct PermissionDeniedView: View {
    let onOpenSettings: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Calendar Access Required", comment: "Title for calendar permission prompt")
                .font(.title)

            Text("Please enable calendar access in System Settings.", comment: "Description for calendar permission denied state")
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button(action: onOpenSettings) {
                Text("Open System Settings", comment: "Button to open System Settings")
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

#Preview("Permission Denied") {
    PermissionDeniedView(onOpenSettings: {})
        .frame(width: 400, height: 300)
}
