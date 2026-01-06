import SwiftUI

struct Header: View {
    var hasAvatar = true
    
    var body: some View {
        HStack {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 140, height: 40)
            
            if hasAvatar {
                Spacer()
                Image("profile-image-placeholder")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            }
        }
        .padding()
    }
}

#Preview {
    Header()
}
