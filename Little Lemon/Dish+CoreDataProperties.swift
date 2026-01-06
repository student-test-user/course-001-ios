public import Foundation
public import CoreData


public typealias DishCoreDataPropertiesSet = NSSet

extension Dish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }

    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var category: String?
    @NSManaged public var image: String?
    @NSManaged public var price: String?

}

extension Dish : Identifiable {

}
