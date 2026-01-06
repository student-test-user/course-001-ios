import SwiftUI

struct Onboarding: View {
    var onComplete: () -> Void
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    
    @FocusState private var firstNameFocused: Bool
    @FocusState private var lastNameFocused: Bool
    @FocusState private var emailFocused: Bool
    
    @State var didRequireError: Bool = false
    @State var didEmailError: Bool = false
    
    @State var currentPage = 0
    
    var keyboardShown: Bool {
        return firstNameFocused || lastNameFocused || emailFocused
    }
    
    var body: some View {
        VStack(spacing: 10) {
            TabView(selection: $currentPage) {
                VStack {
                    Header(hasAvatar: false)
                }
                .tag(0)
                
                VStack {
                    Hero()
                }
                .tag(1)
                
                VStack {
                    Header(hasAvatar: false)
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            if (!keyboardShown) {
                                Hero()
                            }
                            
                            VStack(spacing: 16) {
                                Text("Registration").font(.title).padding(.bottom, 20)
                                StyledTextField("First Name", text: $firstName)
                                    .focused($firstNameFocused)
                                StyledTextField("Last Name", text: $lastName)
                                    .focused($lastNameFocused)
                                StyledTextField("Email", text: $email)
                                    .keyboardType(.emailAddress)
                                    .focused($emailFocused)
                            }
                            .padding()
                        }
                    }
                }
                .tag(2)
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
            VStack {
                if (currentPage < 2) {
                    Button("Next") {
                        withAnimation {
                            currentPage += 1
                        }
                    }
                    .buttonStyle(PrimaryButtonStyle())
                } else {
                    Button("Register") {
                        if (firstName.isEmpty || lastName.isEmpty || email.isEmpty) {
                            didRequireError = true
                        } else if (!email.contains("@") || !email.contains(".")) {
                            didEmailError = true
                        } else {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            
                            onComplete()
                        }
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .alert(
                        "Please fill in all fields",
                        isPresented: $didRequireError
                    ) {}
                    .alert(
                        "Email is incorrect",
                        isPresented: $didEmailError
                    ) {}
                }
            }
            .padding()
        }
    }
}

#Preview {
    Onboarding(onComplete: {})
}
