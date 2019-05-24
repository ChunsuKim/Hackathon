//
//  DetailViewController.swift
//  Dairy
//
//  Created by 차수연 on 21/05/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  let cardView = UIView()
  let imageView = UIImageView()
  let label = UILabel() // 날짜Label
  let textView = UITextView()
  
  let button = UIButton(type: .system)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addSubview()
    autoLayout()
    configure()
    
  }
  
  func addSubview() {
    view.addSubview(cardView)
    view.addSubview(button)
    
    cardView.addSubview(imageView)
    cardView.addSubview(label)
    cardView.addSubview(textView)
    
  }
  
  func autoLayout() {
    let guide = view.safeAreaLayoutGuide
    button.translatesAutoresizingMaskIntoConstraints = false
    button.topAnchor.constraint(equalTo: guide.topAnchor, constant: 10).isActive = true
    button.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10).isActive = true
    button.widthAnchor.constraint(equalToConstant: 30).isActive = true
    button.heightAnchor.constraint(equalToConstant: 10).isActive = true
    
    cardView.translatesAutoresizingMaskIntoConstraints = false
    cardView.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
    cardView.centerYAnchor.constraint(equalTo: guide.centerYAnchor).isActive = true
    cardView.widthAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 0.9).isActive = true
    cardView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.9).isActive = true
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
    imageView.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
    imageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
    imageView.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.4).isActive = true
    
    label.translatesAutoresizingMaskIntoConstraints = false
    label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
    label.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
    label.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
    label.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.05).isActive = true
    
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
    textView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
    textView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
    textView.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.5).isActive = true
  }
  
  func configure() {
    view.backgroundColor = #colorLiteral(red: 0.460631609, green: 0.8378008604, blue: 0.9999235272, alpha: 1)
    
    button.setTitle("뒤로", for: .normal)
    button.addTarget(self, action: #selector(didTapBackButton(_:)), for: .touchUpInside)
    
    cardView.backgroundColor = .white
    cardView.layer.cornerRadius = 20
    cardView.layer.shadowColor = UIColor.black.cgColor
    cardView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
    cardView.layer.shadowOpacity = 0.2
    cardView.layer.shadowRadius = 4.0
    
    imageView.backgroundColor = #colorLiteral(red: 0.737007916, green: 0.7005161643, blue: 0.9055165648, alpha: 1)
    imageView.layer.cornerRadius = 20
    imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    
    label.text = "2019년 5월 22일"
    label.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    label.textAlignment = .center
    
    textView.layer.cornerRadius = 10
    textView.layer.borderWidth = 2
    textView.layer.borderColor = #colorLiteral(red: 0.9212495685, green: 0.9219488502, blue: 0.9213578105, alpha: 1)
    textView.clipsToBounds = true

  }
  @objc func didTapBackButton(_ sender: UIButton) {
    dismiss(animated: true)
  }
  
}
