//
//  Song.swift
//  setList1
//
//  Created by Nicolaas Vallee on 2016-06-07.
//  Copyright © 2016 Nicolaas Vallee. All rights reserved.
//

import UIKit

class Song: NSObject, NSCoding {
    // MARK: Properties
    
    var name: String
    var note: String?
    var rating: Int
    
    // MARK: Archiving Paths

    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("songs")


    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let noteKey = "note"
        static let ratingKey = "rating"
    }
 

    
    // MARK: Initialization
    
    init?(name: String, note: String?, rating: Int) {
        // Initialize stored properties.
        self.name = name
        self.note = note
        self.rating = rating
        

        super.init()
        
        // Initialization should fail if there is no name.
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(note, forKey: PropertyKey.noteKey)
        aCoder.encodeInteger(rating, forKey: PropertyKey.ratingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        
        // Because note is an optional property of Song, use conditional cast.
        
        let note = aDecoder.decodeObjectForKey(PropertyKey.noteKey) as? String
        
        let rating = aDecoder.decodeIntegerForKey(PropertyKey.ratingKey)
        
        // Must call designated initializer.
        self.init(name: name, note: note, rating: rating)
    }
}
