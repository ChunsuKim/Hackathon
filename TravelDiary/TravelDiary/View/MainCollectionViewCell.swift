//
//  MainCollectionViewCell.swift
//  TravelDiary
//
//  Created by Chunsu Kim on 25/06/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    static let identifier = "MainCollectionViewCell"
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        clipsToBounds = true
        layer.cornerRadius = 20
        
        // imageView
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
        
        // titleLabel
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.backgroundColor = .black
//        titleLabel.text = "잠실야경"
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        contentView.addSubview(titleLabel)
    }
    
    private func configureConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    func configureCellContent(image: UIImage?, title: String) {
        imageView.image = image
        titleLabel.text = title
    }
    
}
