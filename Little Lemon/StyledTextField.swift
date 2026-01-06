import SwiftUI

struct StyledTextField: View {
    private let title: String
    @Binding private var text: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        TextField("", text: $text, prompt: Text(title).foregroundColor(.gray))
            .foregroundColor(.black)
            .padding(10)
            .background(Color.white)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.gray, lineWidth: 1)
            )
    }
}

#Preview {
    @Previewable @State var value = ""
    
    VStack {
        StyledTextField("Placeholder text", text: $value)
    }
    .padding()
    .background(Color.gray.opacity(0.2))
}
