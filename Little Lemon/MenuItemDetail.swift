import SwiftUI
import CoreData

struct MenuItemDetail: View {
    let dish: Dish

    var body: some View {
        VStack {
            if let image = dish.image {
                AsyncImage(url: URL(string: image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 400, height: 200, alignment: .center)
                } placeholder: {
                    ProgressView()
                }
            }
            if let price = dish.price {
                Text("$\(price)").font(.title)
            }
            if let category = dish.category {
                Text(category).font(.headline)
            }
        }
        .navigationTitle(dish.title ?? "Dish Details")
    }
}

#Preview {
    MenuItemDetail(dish: Dish())
}
