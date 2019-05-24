//
//  CustomCollectionViewCell.swift
//  Dairy
//
//  Created by 차수연 on 21/05/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
  static let identifier = "CustomCollectionViewCell"
  
  let view = UIView()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview()
    autoLayout()
    configure()
    
  }
  
  func addSubview() {
    contentView.addSubview(view)
  }
  
  func autoLayout() {
    view.translatesAutoresizingMaskIntoConstraints = false
    view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    view.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
    view.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
    
  }
  
  func configure() {
    view.backgroundColor = Thema.cardView
    
    view.layer.cornerRadius = 20
    
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOffset = CGSize(width: 0, height: 1.0)
    view.layer.shadowOpacity = 0.2
    view.layer.shadowRadius = 4.0
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
