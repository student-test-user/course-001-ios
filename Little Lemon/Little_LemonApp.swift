import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"

extension EnvironmentValues {
  @Entry var isLoggedIn: Bool = false
}

@main
struct Little_LemonApp: App {
    @State private var isLoggedIn: Bool = UserDefaults.standard.string(forKey: kEmail) != nil
    
    var body: some Scene {
        WindowGroup {
            Group {
                if isLoggedIn {
                    Home(onLogout: {
                        isLoggedIn = false
                    })
                } else {
                    Onboarding(onComplete: {
                        isLoggedIn = true
                    })
                }
            }
        }
    }
}
