//
//  ViewController.swift
//  Dairy
//
//  Created by Chunsu Kim on 20/05/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let topView = UIView()
    let labelStack = UIStackView()
    let dateLabel = UILabel()
    let mainLabel = UILabel()
    let buttonView = UIView()
    let writeButton = UIButton()
    let textView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        autoLayout()
    }
    
    func configure() {
        labelStack.axis = .vertical
        
        dateLabel.text = "2019년 8월 16일"
        dateLabel.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        dateLabel.textColor = #colorLiteral(red: 0.1746840775, green: 0.4984993339, blue: 0.7566666007, alpha: 1)
        dateLabel.text = todayDate()
        
        mainLabel.text = "안녕하세요. \n오늘 하루 어땠나요 ?"
        mainLabel.numberOfLines = 0
        mainLabel.textColor = #colorLiteral(red: 0.2571163177, green: 0.7560217977, blue: 0.9694374204, alpha: 1)
        mainLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        
        writeButton.setTitle("입력하기", for: .normal)
        writeButton.backgroundColor = #colorLiteral(red: 0.2398266494, green: 0.6760053039, blue: 0.9694671035, alpha: 1)
        writeButton.layer.cornerRadius = 10
        writeButton.clipsToBounds = true
        writeButton.addTarget(nil, action: #selector(writeButtonDidTap(_:)), for: .touchUpInside)
        
        textView.tintColor = .black
        textView.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 2
        textView.layer.borderColor = #colorLiteral(red: 0.9212495685, green: 0.9219488502, blue: 0.9213578105, alpha: 1)
        textView.clipsToBounds = true
        textView.isHidden = true
        
        view.addSubview(labelStack)
        view.addSubview(writeButton)
        view.addSubview(textView)
        labelStack.addArrangedSubview(dateLabel)
        labelStack.addArrangedSubview(mainLabel)
    }
    
    func autoLayout() {
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        labelStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        labelStack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        writeButton.translatesAutoresizingMaskIntoConstraints = false
        writeButton.topAnchor.constraint(equalTo: labelStack.bottomAnchor, constant: 10).isActive = true
        writeButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        writeButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        writeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: writeButton.bottomAnchor, constant: 10).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
    
    func todayDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 m월 d일"
        let now = Date()
        let dateString = formatter.string(from: now)
        return dateString
    }
    
    @objc func writeButtonDidTap(_ sender: UIButton) {
        if textView.isHidden {
            textView.isHidden = false
            UIView.setAnimationsEnabled(false)
            writeButton.setTitle("기록하기", for: .normal)
            view.layoutIfNeeded()
            UIView.setAnimationsEnabled(true)
            UIView.animate(withDuration: 0.7, animations: {
                self.labelStack.frame = CGRect(x: self.view.layoutMarginsGuide.layoutFrame.minX,
                                               y: self.view.layoutMarginsGuide.layoutFrame.minY + 10,
                                               width: self.labelStack.frame.width,
                                               height: self.labelStack.frame.height)
                self.writeButton.frame = CGRect(x: self.view.layoutMarginsGuide.layoutFrame.minX,
                                                y: self.labelStack.frame.maxY + 10,
                                                width: self.writeButton.frame.width,
                                                height: self.writeButton.frame.height)
                self.textView.frame = CGRect(x: self.textView.frame.minX,
                                             y: self.writeButton.frame.maxY + 10,
                                             width: self.textView.frame.width,
                                             height: self.view.frame.maxY - self.writeButton.frame.maxY - 15)
            }, completion: nil)
        } else {
            textView.isHidden = true
            UIView.animate(withDuration: 1, animations: {
                self.writeButton.setTitle("입력하기", for: .normal)
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    


}

