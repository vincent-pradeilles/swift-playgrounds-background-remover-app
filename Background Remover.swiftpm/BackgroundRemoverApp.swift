import SwiftUI

@main
struct BackgroundRemoverApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ImageList()
            }
            .navigationViewStyle(.stack)
        }
    }
}
