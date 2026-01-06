import SwiftUI

struct UserProfile: View {
    var onLogout: () -> Void
    
    @State var firstName = UserDefaults.standard.string(forKey: kFirstName) ?? "First Name"
    @State var lastName = UserDefaults.standard.string(forKey: kLastName) ?? "Last Name"
    @State var email = UserDefaults.standard.string(forKey: kEmail) ?? "email@example.com"
    
    var body: some View {
        VStack {
            Header()
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Personal information").font(.title)
                    Image("profile-image-placeholder")
                        .clipShape(Circle())
                        .padding(.bottom)
                    
                    Text("First name")
                    StyledTextField("", text: $firstName)
                        .disabled(true)
                    
                    Text("Last name")
                        .padding(.top)
                    StyledTextField("", text: $lastName)
                        .disabled(true)
                    
                    Text("Email")
                        .padding(.top)
                    StyledTextField("", text: $email)
                        .disabled(true)
                    
                    Button("Log out") {
                        UserDefaults.standard.removeObject(forKey: kFirstName)
                        UserDefaults.standard.removeObject(forKey: kLastName)
                        UserDefaults.standard.removeObject(forKey: kEmail)
                        
                        onLogout()
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .padding(.top, 40)
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {
    UserProfile() {}
}
