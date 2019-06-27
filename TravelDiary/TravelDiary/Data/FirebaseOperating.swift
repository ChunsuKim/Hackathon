//
//  FirebaseOperating.swift
//  TravelDiary
//
//  Created by JinBae Jeong on 26/06/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

final class FireBaseOperating {
    
    static let Share = FireBaseOperating()
    
    var ref: DatabaseReference!
    var databaseHandle: DatabaseHandle?
    
    init() {
        ref = Database.database().reference()
    }
    
    func writeFoodList(data: DataClass) {
        let keyPath = ref.child("Foods").childByAutoId()// else { return print("firebase create key fail")}
        
        keyPath.updateChildValues(["title": data.title])
        keyPath.updateChildValues(["contents": data.contents])
        keyPath.updateChildValues(["registerDate": data.registerDate])
        keyPath.updateChildValues(["registerDate": data.location])
        
        // TODO : write Image Data
//        if let image = CollVC.food.images[food.iconImage] as? UIImage {
//            self.uploadImage(image: image, name: food.iconImage)
//        }
//        if let image = CollVC.food.images[food.meterialImages[0]] as? UIImage {
//            self.uploadImage(image: image, name: food.meterialImages[0])
//        }
//        if let image = CollVC.food.images[food.meterialImages[1]] as? UIImage {
//            self.uploadImage(image: image, name: food.meterialImages[1])
//        }
        
//        NotificationCenter.default.post(name: .reload, object: nil)
    }
}
