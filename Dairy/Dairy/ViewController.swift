//
//  ViewController.swift
//  Dairy
//
//  Created by Chunsu Kim on 20/05/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
//    let topView = UIView()
    let labelStack = UIStackView()
    let dateLabel = UILabel()
    let mainLabel = UILabel()
//    let buttonView = UIView()
    let writeButton = UIButton()
    let textView = UITextView()
    let imageView = UIImageView()
    var subject: String?
    private var isHidden = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        autoLayout()
    }
    
    // MARK: - Setting Method
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
        writeButton.addTarget(nil, action: #selector(writeButtonDidTap), for: .touchUpInside)
        
        imageView.backgroundColor = #colorLiteral(red: 0.737007916, green: 0.7005161643, blue: 0.9055165648, alpha: 1)
        imageView.layer.borderColor = #colorLiteral(red: 0.5003563166, green: 0.4739893079, blue: 0.9927108884, alpha: 1)
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        imageView.isHidden = true
        
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
        view.addSubview(imageView)
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
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: writeButton.bottomAnchor, constant: 10).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
    
    func todayDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일"
        let now = Date()
        let dateString = formatter.string(from: now)
        return dateString
    }
    
    // MARK: - Action Method
    @objc func writeButtonDidTap() {
        if isHidden == true {
            textView.isHidden = false
            imageView.isHidden = false
            UIView.setAnimationsEnabled(false)
            writeButton.setTitle("기록하기", for: .normal)
            view.layoutIfNeeded()
            UIView.setAnimationsEnabled(true)
            UIView.animate(withDuration: 0.7, animations: {
                self.labelStack.frame = CGRect(
                    x: self.view.layoutMarginsGuide.layoutFrame.minX,
                    y: self.view.layoutMarginsGuide.layoutFrame.minY + 10,
                    width: self.labelStack.frame.width,
                    height: self.labelStack.frame.height)
                
                self.writeButton.frame = CGRect(
                    x: self.view.layoutMarginsGuide.layoutFrame.minX,
                    y: self.labelStack.frame.maxY + 10,
                    width: self.writeButton.frame.width,
                    height: self.writeButton.frame.height)
                
                self.imageView.frame = CGRect(
                    x: self.imageView.frame.minX,
                    y: self.writeButton.frame.maxY + 10,
                    width: self.imageView.frame.width,
                    height: self.view.frame.maxY * 3/5 - self.writeButton.frame.maxY - 15)
                
                self.textView.frame = CGRect(
                    x: self.textView.frame.minX,
                    y: self.imageView.frame.maxY + 10,
                    width: self.textView.frame.width,
                    height: self.view.frame.maxY - self.imageView.frame.maxY - 15)
            }, completion: nil)
            isHidden.toggle()
        } else {
            textView.isHidden = true
            imageView.isHidden = true
            UIView.animate(withDuration: 1, animations: {
                self.saveSomeWords()
                self.writeButton.setTitle("입력하기", for: .normal)
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            isHidden.toggle()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: touch.view)
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        if imageView.frame.contains(touchPoint) {
            present(picker, animated: false)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        writeButtonDidTap()
    }
    
    private func saveSomeWords() {
        print("save")
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let originalImage = info[.originalImage] as! UIImage
        self.imageView.image = originalImage
        
        picker.dismiss(animated: false) {
            self.writeButtonDidTap()
            self.writeButtonDidTap()
        }
    }
}
