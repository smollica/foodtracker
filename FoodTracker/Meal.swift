//
//  Meal.swift
//  FoodTracker
//
//  Created by Monica Mollica on 2016-04-11.
//  Copyright © 2016 Sergio Mollica. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
    
    // MARK: Properties
    
    var name: String
    var rating: Int
    var image: UIImage?

    // MARK: Init
    
    init?(name: String, image: UIImage?, rating: Int) {
        self.name = name
        self.rating = rating
        self.image = image
        
        super.init()
        
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    
    // MARK: Data Persistance
    
    struct PropertyKey {
        static let nameKey = "name"
        static let imageKey = "image"
        static let ratingKey = "rating"
    }
    
    // MARK: NSCoding Protocol
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(image, forKey: PropertyKey.imageKey)
        aCoder.encodeInteger(rating, forKey: PropertyKey.ratingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        
        let image = aDecoder.decodeObjectForKey(PropertyKey.imageKey) as? UIImage
        
        let rating = aDecoder.decodeIntegerForKey(PropertyKey.ratingKey)
        
        self.init(name: name, image: image, rating: rating)
    }
}
