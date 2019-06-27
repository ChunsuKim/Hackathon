//
//  DataClass.swift
//  TravelDiary
//
//  Created by Chunsu Kim on 25/06/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import UIKit
import CoreData

class MemoData {
    var memoIndex: Int?
    var title: String?          // 제목
    var contents: String?       // 내용
    var image: UIImage?         // 이미지
    var registerDate: Date?     // 작성일
//    var location: String?       // 장소
    
    var objectID: NSManagedObjectID?
    
}
