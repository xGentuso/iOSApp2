import Foundation

struct MenuItem: Identifiable, Codable {
    let id: UUID
    let name: String
    let description: String
    let price: Double
    let imageName: String?
    
    init(id: UUID = UUID(), name: String, description: String, price: Double, imageName: String? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.imageName = imageName
    }
}
