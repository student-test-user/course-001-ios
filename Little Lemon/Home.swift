import SwiftUI
import CoreData

struct Home: View {
    var onLogout: () -> Void
    
    let persistence = PersistenceController.shared
    
    var body: some View {
        TabView() {
            Menu()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
                .environment(\.managedObjectContext, persistence.container.viewContext)
            
            UserProfile(onLogout: onLogout)
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }
    }
}

#Preview {
    Home() {}
}
