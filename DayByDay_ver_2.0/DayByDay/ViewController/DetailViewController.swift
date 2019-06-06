//
//  DetailViewController.swift
//  DayByDay
//
//  Created by Chunsu Kim on 23/05/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var savedData : MemoData?
//    let cardViewForImage = UIView()
    let cardView = UIView()
    let stackView = UIStackView()
    let scrollView = UIScrollView()
    let contents = UITextView()
    let imageView = UIImageView()
    let registerDateLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubview()
        configure()
        autoLayout()
        printView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    func addSubview() {
        view.addSubview(cardView)
//        view.addSubview(cardViewForImage)
        cardView.addSubview(scrollView)
//        cardViewForImage.addSubview(imageView)
        view.addSubview(imageView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(registerDateLabel)
        stackView.addArrangedSubview(contents)
        
//        cardView.addSubview(contents)
//        cardView.addSubview(registerDateLabel)
    }
    
    func autoLayout() {
        let guide = view.safeAreaLayoutGuide
        
//        cardViewForImage.translatesAutoresizingMaskIntoConstraints = false
//        cardViewForImage.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
//        cardViewForImage.centerYAnchor.constraint(equalTo: guide.centerYAnchor).isActive = true
//        cardViewForImage.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20).isActive = true
//        cardViewForImage.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20).isActive = true
//        cardViewForImage.topAnchor.constraint(equalTo: guide.topAnchor, constant: 20).isActive = true
//        cardViewForImage.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier:  0.3).isActive = true
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        cardView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20).isActive = true
        cardView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20).isActive = true
        cardView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -20).isActive = true
//        cardView.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
//        cardView.centerYAnchor.constraint(equalTo: guide.centerYAnchor).isActive = true
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.45)
        
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.topAnchor.constraint(equalTo: cardViewForImage.topAnchor).isActive = true
//        imageView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20).isActive = true
//        imageView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20).isActive = true
//        imageView.bottomAnchor.constraint(equalTo: cardViewForImage.bottomAnchor).isActive = true
        
//        registerDateLabel.translatesAutoresizingMaskIntoConstraints = false
//        registerDateLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
//        registerDateLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
//        registerDateLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
//        registerDateLabel.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.05).isActive = true
        
        
        contents.translatesAutoresizingMaskIntoConstraints = false
//        contents.heightAnchor.constraint(equalToConstant: 500).isActive = true
//        contents.topAnchor.constraint(equalTo: registerDateLabel.bottomAnchor, constant: 10).isActive = true
//        contents.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
//        contents.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        contents.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
        
    }
    
    func configure() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let toolBarKeyboard = UIToolbar()
        toolBarKeyboard.sizeToFit()
        let buttonflexBar = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let buttonDoneBar = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(self.doneButtonClicked(_sender:)))
        toolBarKeyboard.items = [buttonflexBar, buttonDoneBar]
        toolBarKeyboard.tintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        
      
        cardView.backgroundColor = .white
        cardView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        cardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowRadius = 4.0
        cardView.clipsToBounds = true
        
//        cardViewForImage.backgroundColor = .white
//        cardViewForImage.layer.cornerRadius = 20
//        cardViewForImage.layer.shadowColor = UIColor.black.cgColor
//        cardViewForImage.layer.shadowOffset = CGSize(width: 0, height: 1.0)
//        cardViewForImage.layer.shadowOpacity = 0.2
//        cardViewForImage.layer.shadowRadius = 4.0
        
        contents.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        contents.textColor = #colorLiteral(red: 0.2683359385, green: 0.3678353727, blue: 0.7584179044, alpha: 1)
        contents.layer.cornerRadius = 10
        contents.layer.borderColor = #colorLiteral(red: 0.2142035365, green: 0.6806999445, blue: 0.986015141, alpha: 1)
        contents.layer.borderWidth = 0.5
        contents.clipsToBounds = true
        contents.textAlignment = .center
        contents.inputAccessoryView = toolBarKeyboard
        contents.text = "asdfasdfsdf"
        
        registerDateLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        registerDateLabel.textColor = #colorLiteral(red: 0.2683359385, green: 0.3678353727, blue: 0.7584179044, alpha: 1)
      
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.backgroundColor = .red
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
//        stackView.spacing = 10
    }
    
    func printView() {
        // 제목, 내용, 이미지 출력
        self.contents.text = savedData?.contents
        self.imageView.image = savedData?.image
        
        // 날짜 포맷 변환
        let formatter = DateFormatter()
        formatter.dateFormat = "dd일 HH:mm분에 작성됨"
        let dateString = formatter.string(from: (savedData?.registerDate)!)
        
        // 레이블에 날짜 표시
        self.registerDateLabel.text = dateString
    }
    
    @objc func doneButtonClicked (_sender: Any) {
        self.view.endEditing(true)
    }
    

    

    

}
