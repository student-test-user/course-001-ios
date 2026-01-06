import SwiftUI
import CoreData

struct DishMenuItem: View {
    var dish: Dish
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if let title = dish.title {
                    Text(title)
                        .font(.headline)
                }
                if let price = dish.price {
                    Text(price)
                        .font(.caption)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if let image = dish.image {
                AsyncImage(url: URL(string: image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                .clipped()
            }
        }
        .padding()
    }
}

#Preview {
    let context = PersistenceController.shared.container.viewContext
    let dish = Dish(context: context)
    dish.title = "Greek Salad"
    dish.price = "10.99"
    dish.image = "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true"
    return DishMenuItem(dish: dish)
}
