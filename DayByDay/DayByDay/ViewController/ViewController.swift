//
//  ViewController.swift
//  DayByDay
//
//  Created by Chunsu Kim on 23/05/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    let scrollView = UIScrollView()
    let labelStack = UIStackView()
    let dateLabel = UILabel()
    let mainLabel = UILabel()
    let writeButton = UIButton()
    let textView = UITextView()
    let imageView = UIImageView()
    var subject: String?
    private var isHidden = true
    lazy var dao = MemoDAO()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        autoLayout()
    }
    
    // MARK: - Setting Method
    func configure() {
        let toolBarKeyboard = UIToolbar()
        toolBarKeyboard.sizeToFit()
        let buttonflexBar = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let buttonDoneBar = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(self.doneButtonClicked(_sender:)))
        toolBarKeyboard.items = [buttonflexBar, buttonDoneBar]
        toolBarKeyboard.tintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
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
        
        scrollView.isHidden = true
        scrollView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        imageView.backgroundColor = #colorLiteral(red: 0.737007916, green: 0.7005161643, blue: 0.9055165648, alpha: 1)
        imageView.layer.borderColor = #colorLiteral(red: 0.5003563166, green: 0.4739893079, blue: 0.9927108884, alpha: 1)
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        imageView.isHidden = true
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewDidTap(_:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(imageTapGesture)
        
        textView.tintColor = .black
        textView.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 2
        textView.layer.borderColor = #colorLiteral(red: 0.9212495685, green: 0.9219488502, blue: 0.9213578105, alpha: 1)
        textView.clipsToBounds = true
        textView.isHidden = true
        textView.delegate = self
        textView.inputAccessoryView = toolBarKeyboard
        
        view.addSubview(labelStack)
        view.addSubview(writeButton)
        view.addSubview(scrollView)
        scrollView.addSubview(textView)
        scrollView.addSubview(imageView)
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
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: writeButton.bottomAnchor, constant: 10).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        textView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        textView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 600).isActive = true
        textView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10).isActive = true
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
            scrollView.isHidden = false
            textView.isHidden = false
            imageView.isHidden = false
//            UIView.setAnimationsEnabled(false)
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
                
                self.scrollView.frame = CGRect(
                    x: self.scrollView.frame.minX,
                    y: self.writeButton.frame.maxY + 10,
                    width: self.scrollView.frame.width,
                    height: self.view.frame.maxY - self.writeButton.frame.maxY - 15)
                
                self.imageView.frame = CGRect(
                    x: self.scrollView.frame.minX,
                    y: self.scrollView.frame.minY,
                    width: self.imageView.frame.width,
                    height: self.scrollView.frame.maxY * 3/5)
                
                self.textView.frame = CGRect(
                    x: self.textView.frame.minX,
                    y: self.imageView.frame.maxY + 10,
                    width: self.textView.frame.width,
                    height: self.view.frame.maxY - self.imageView.frame.maxY - 15)
            }, completion: nil)
            isHidden.toggle()
        } else {
            scrollView.isHidden = true
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
    
    @objc func doneButtonClicked (_sender: Any) {
        self.view.endEditing(true)
    }
    
    @objc func imageViewDidTap(_ sender: UIImageView) {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: false)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        guard let touch = touches.first else { return }
//        let touchPoint = touch.location(in: touch.view)
//        let picker = UIImagePickerController()
//
//        picker.delegate = self
//        picker.allowsEditing = true
//
//        if imageView.frame.contains(touchPoint) {
//            present(picker, animated: false)
//        }
//    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //        writeButtonDidTap()
    }
    
    private func saveSomeWords() {
        print("save")
        
        // MemoData 객체를 생성, 데이터를 담는다
        let data = MemoData()
        
        data.title = self.subject   // 제목
        data.contents = self.textView.text    // 내용
        data.image = self.imageView.image   // 이미지
        data.registerDate = Date() // 작성 날
        
        // AppDelegate 객체를 읽어온 다음, memolist 배열에 MemoData 객체를 추가
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.memolist.append(data)
        
        // 코어 데이터에 메모 데이터를 추가한다
        self.dao.insert(data)
        
        
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

extension ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        // 내용의 최대 10자리까지 읽어 subject 변수에 저장
        let contents = textView.text as NSString
        let length = ((contents.length > 10) ? 10 : contents.length)
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        // 네비게이션 타이틀에 표시
        //        self.navigationItem.title = subject
    }

}

