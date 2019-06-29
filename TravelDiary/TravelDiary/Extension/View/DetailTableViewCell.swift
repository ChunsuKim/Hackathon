//
//  DetailTableViewCell.swift
//  TravelDiary
//
//  Created by Chunsu Kim on 28/06/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    static let identifier = "DetailTableViewCell"
    let thermometerLabel = UILabel()
    let statusLabel = UILabel()
    let weatherImageView = UIImageView()
    let dateLabel = UILabel()
    let timeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCellUserInterface()
        configureConstraints()
        backgroundColor = UIColor.clear
        
        statusLabel.textColor = UIColor.white
        dateLabel.textColor = statusLabel.textColor
        timeLabel.textColor = statusLabel.textColor
        thermometerLabel.textColor = statusLabel.textColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func configureCellUserInterface() {
        thermometerLabel.text = "00"
        thermometerLabel.font = UIFont.systemFont(ofSize: 40, weight: .thin)
        statusLabel.font = UIFont.systemFont(ofSize: 30)
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        timeLabel.textColor = .lightGray
        
        contentView.addSubview(thermometerLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(timeLabel)
    }
    
    private func configureConstraints() {
        
        thermometerLabel.translatesAutoresizingMaskIntoConstraints = false
        thermometerLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        thermometerLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        thermometerLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
        thermometerLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        thermometerLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        thermometerLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        thermometerLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.centerYAnchor.constraint(equalTo: thermometerLabel.centerYAnchor).isActive = true
        statusLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.centerYAnchor.constraint(equalTo: statusLabel.centerYAnchor).isActive = true
        weatherImageView.trailingAnchor.constraint(equalTo: statusLabel.leadingAnchor, constant: -10).isActive = true
        weatherImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        weatherImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    

}
