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
    
    private let mainCellImageView = UIImageView()
    private let mainCellTitleLabel = UILabel()
    
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
        mainCellImageView.contentMode = .scaleAspectFill
        contentView.addSubview(mainCellImageView)
        
        // titleLabel
        mainCellTitleLabel.textAlignment = .center
        mainCellTitleLabel.textColor = .white
        mainCellTitleLabel.backgroundColor = .black
        mainCellTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        contentView.addSubview(mainCellTitleLabel)
    }
    
    private func configureConstraints() {
        mainCellImageView.translatesAutoresizingMaskIntoConstraints = false
        mainCellImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mainCellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        mainCellImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        mainCellTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        mainCellTitleLabel.topAnchor.constraint(equalTo: mainCellImageView.bottomAnchor).isActive = true
        mainCellTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        mainCellTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        mainCellTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        mainCellTitleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        mainCellTitleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    func configureCellContent(image: UIImage?, title: String?) {
        mainCellImageView.image = image
        mainCellTitleLabel.text = title
    }
    
}
