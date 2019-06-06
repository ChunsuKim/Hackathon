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
    
    private func addSubview() {
        
        view.addSubview(imageView)
        view.addSubview(contents)
        view.addSubview(registerDateLabel)
    }
    
    private func autoLayout() {
        let guide = view.safeAreaLayoutGuide
        
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.45)
        
        registerDateLabel.translatesAutoresizingMaskIntoConstraints = false
        registerDateLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        registerDateLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20).isActive = true
        registerDateLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20).isActive = true
        registerDateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        contents.translatesAutoresizingMaskIntoConstraints = false
        contents.topAnchor.constraint(equalTo: registerDateLabel.bottomAnchor, constant: 10).isActive = true
        contents.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20).isActive = true
        contents.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20).isActive = true
        contents.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -20).isActive = true
        
    }
    
    private func configure() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let toolBarKeyboard = UIToolbar()
        toolBarKeyboard.sizeToFit()
        let buttonflexBar = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let buttonDoneBar = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(self.doneButtonClicked(_sender:)))
        toolBarKeyboard.items = [buttonflexBar, buttonDoneBar]
        toolBarKeyboard.tintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
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
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func printView() {
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
    
    @objc private func doneButtonClicked (_sender: Any) {
        self.view.endEditing(true)
    }
}
