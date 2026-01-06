import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var hasLoadedData = false
    @State private var searchText = ""
    @State private var selectedCategory = ""
    @State private var allCategories: [String] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                Header()
                
                FetchedObjects(
                    predicate: buildPredicate(),
                    sortDescriptors: buildSortDescriptors()
                ) { (dishes: [Dish]) in
                    ScrollView {
                        Hero {
                            StyledTextField("Search menu", text: $searchText)
                        }
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("ORDER FOR DELIVERY!")
                                .font(.headline)

                            HStack(spacing: 10) {
                                ForEach(allCategories, id: \.self) { category in
                                    Button {
                                        if selectedCategory == category {
                                            selectedCategory = ""
                                        } else {
                                            selectedCategory = category
                                        }
                                    } label: {
                                        Text(category)
                                            .font(.subheadline)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 8)
                                            .background(selectedCategory == category ? Color(.approvedGreen) : Color(.approvedLightGreen))
                                            .foregroundColor(selectedCategory == category ? Color(.approvedLightGreen) : Color(.approvedGreen))
                                            .cornerRadius(12)
                                    }
                                }
                            }
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        
                        ForEach(dishes) { dish in
                            NavigationLink(value: dish) {
                                DishMenuItem(dish: dish)
                            }
                        }
                    }
                    .navigationDestination(for: Dish.self) { value in
                        MenuItemDetail(dish: value)
                    }
                }
            }
            
        }
        .onAppear {
            if !hasLoadedData {
                getMenuData()
                hasLoadedData = true
            }
        }
    }
    
    private func getMenuData() {
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!

        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else { return }
            
            PersistenceController.shared.clear()

            Task { @MainActor in
                do {
                    let decoder = JSONDecoder()
                    let menuList = try decoder.decode(MenuList.self, from: data)

                    for item in menuList.menu {
                        let dish = Dish(context: viewContext)
                        dish.id = item.id
                        dish.title = item.title
                        dish.image = item.image
                        dish.price = item.price
                        dish.category = item.category
                    }

                    try viewContext.save()
                    
                    allCategories = Array(Set(menuList.menu.map { $0.category })).sorted()
                } catch {
                    print("Menu decode/save error: \(error)")
                }
            }
        }
        task.resume()
    }
    
    private func buildSortDescriptors() -> [NSSortDescriptor] {
        [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))]
    }
    
    private func buildPredicate() -> NSPredicate {
        var predicates: [NSPredicate] = []
        
        if !searchText.isEmpty {
            predicates.append(NSPredicate(format: "title CONTAINS[cd] %@", searchText))
        }
        
        if !selectedCategory.isEmpty {
            predicates.append(NSPredicate(format: "category == %@", selectedCategory))
        }
        
        if predicates.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        }
    }
}

#Preview {
    Menu()
}

