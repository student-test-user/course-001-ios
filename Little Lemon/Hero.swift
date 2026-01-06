import SwiftUI

struct Hero<Content: View>: View {
    @ViewBuilder let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content = { EmptyView() }) {
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Little Lemon")
                .font(.largeTitle.bold())
                .foregroundColor(.approvedYellow)
            HStack {
                VStack(alignment: .leading) {
                    Text("Chicago")
                        .font(.headline)
                        .padding(.bottom, 5)
                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                }
                .foregroundColor(.white)
                
                Image("hero")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.approvedGreen))
    }
}

#Preview {
    Hero()
}
