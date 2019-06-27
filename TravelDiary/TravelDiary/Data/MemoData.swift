//
//  MemoData.swift
//  TravelDiary
//
//  Created by Chunsu Kim on 27/06/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import UIKit
import CoreData

class MemoData {
    var memoIndex: Int? // 데이터 식별값
    var title: String?  // 메모 제목
    var contents: String?   // 메모 내용
    var image: UIImage? // 이미지
    var registerDate: Date? // 작성일
    var sDate: Date?
    var eDate: Date?
    
    var objectID: NSManagedObjectID?
    
    
    
}
