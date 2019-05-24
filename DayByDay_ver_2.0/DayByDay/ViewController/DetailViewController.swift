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
    let cardView = UIView()
    let contents = UITextView()
    let imageView = UIImageView()
    let registerDateLabel = UILabel()
//    let button = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubview()
        autoLayout()
        configure()
        printView()
    }
    
    func addSubview() {
        view.addSubview(cardView)
//        view.addSubview(button)
        cardView.addSubview(contents)
        cardView.addSubview(imageView)
        cardView.addSubview(registerDateLabel)
    }
    
    func autoLayout() {
        let guide = view.safeAreaLayoutGuide
        
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.topAnchor.constraint(equalTo: guide.topAnchor, constant: 10).isActive = true
//        button.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20).isActive = true
//        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
      
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
        
        registerDateLabel.translatesAutoresizingMaskIntoConstraints = false
        registerDateLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        registerDateLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        registerDateLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        registerDateLabel.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.05).isActive = true
        
        
        contents.translatesAutoresizingMaskIntoConstraints = false
        contents.topAnchor.constraint(equalTo: registerDateLabel.bottomAnchor, constant: 10).isActive = true
        contents.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        contents.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
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
        
//        button.setTitle("뒤로", for: .normal)
//        button.addTarget(self, action: #selector(didTapBackButton(_:)), for: .touchUpInside)
      
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 20
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowRadius = 4.0
        
        contents.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        contents.textColor = #colorLiteral(red: 0.2683359385, green: 0.3678353727, blue: 0.7584179044, alpha: 1)
        contents.layer.cornerRadius = 10
        contents.layer.borderColor = #colorLiteral(red: 0.2142035365, green: 0.6806999445, blue: 0.986015141, alpha: 1)
        contents.layer.borderWidth = 0.5
        contents.clipsToBounds = true
        contents.textAlignment = .center
        contents.inputAccessoryView = toolBarKeyboard
        
        registerDateLabel.font = UIFont.systemFont(ofSize: 25, weight: .light)
        registerDateLabel.textColor = #colorLiteral(red: 0.2683359385, green: 0.3678353727, blue: 0.7584179044, alpha: 1)
      
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
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
    
//    @objc func didTapBackButton(_ sender: UIButton) {
//        dismiss(animated: true)
//    }
    
    @objc func doneButtonClicked (_sender: Any) {
        self.view.endEditing(true)
    }
    

    

    

}
