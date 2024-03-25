

import SwiftUI

@main
struct ChatApp: App {
    @StateObject var store = Store()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
