//
//  Order.swift
//  CupcakeCorner
//
//  Created by Joel Lacerda on 22/11/24.
//

import Foundation

@Observable
class Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity)*2
        
        // complicated caked cost more
        cost += Decimal(type)/2
        
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity)/2
        }
        
        return cost
    }
    
    var name = "" {
        didSet { saveToUserDefaults() }
    }
    var streetAddress = "" {
        didSet { saveToUserDefaults() }
    }
    var city = "" {
        didSet { saveToUserDefaults() }
    }
    var zip = "" {
        didSet { saveToUserDefaults() }
    }
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespaces).isEmpty ||
            streetAddress.trimmingCharacters(in: .whitespaces).isEmpty ||
            city.trimmingCharacters(in: .whitespaces).isEmpty ||
            zip.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        } else {
            return true
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    // MARK: - UserDefaults Integration
    private static let userDefaultsKey = "SavedOrder"
       
    init() {
        loadFromUserDefaults()
    }
       
    func saveToUserDefaults() {
        if let encodedData = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encodedData, forKey: Order.userDefaultsKey)
        }
    }
       
    func loadFromUserDefaults() {
        if let savedData = UserDefaults.standard.data(forKey: Order.userDefaultsKey),
           let decodedOrder = try? JSONDecoder().decode(Order.self, from: savedData) {
            self.name = decodedOrder.name
            self.streetAddress = decodedOrder.streetAddress
            self.city = decodedOrder.city
            self.zip = decodedOrder.zip
        }
    }
}
