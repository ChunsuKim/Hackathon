//
//  ViewController.swift
//  DayByDay
//
//  Created by Chunsu Kim on 23/05/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import YPImagePicker
import Photos
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
    let textViewLabel = UILabel()
    var subject: String?
    var selectedItems = [YPMediaItem]()
    
    private var isHidden = true
    lazy var dao = MemoDAO()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUserInterface()
        configureConstraints()
        configureNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        changeTheme()
    }
    
    
    
    // MARK: - configuration
    private func configureUserInterface() {
        let toolBarKeyboard = UIToolbar()
        toolBarKeyboard.sizeToFit()
        let buttonflexBar = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let buttonDoneBar = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(self.doneButtonClicked(_sender:)))
        toolBarKeyboard.items = [buttonflexBar, buttonDoneBar]
        toolBarKeyboard.tintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        labelStack.axis = .vertical
        
        dateLabel.text = "2019년 8월 16일"
        dateLabel.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        dateLabel.textColor = Theme.dateLabel
        dateLabel.text = configureTodayDate()
        
        mainLabel.text = "안녕하세요. \n오늘 하루 어땠나요 ?"
        mainLabel.numberOfLines = 0
        mainLabel.textColor = Theme.mainLabel
        mainLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        
        writeButton.setTitle("입력하기", for: .normal)
        writeButton.backgroundColor = Theme.writeButton
        writeButton.layer.cornerRadius = 10
        writeButton.clipsToBounds = true
        writeButton.titleLabel?.textColor = Theme.buttonText
        writeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        writeButton.addTarget(nil, action: #selector(writeButtonDidTap), for: .touchUpInside)
        
        scrollView.isHidden = true
        scrollView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        imageView.contentMode = .scaleAspectFit
        //    imageView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        imageView.image = UIImage(named: "default")
        imageView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
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
        
        textViewLabel.text = "하고싶은 이야기를 입력해주세요"
        textViewLabel.isHidden = true
        textViewLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        textViewLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        textViewLabel.textAlignment = .center
        
        view.addSubview(labelStack)
        view.addSubview(writeButton)
        view.addSubview(scrollView)
        scrollView.addSubview(textView)
        scrollView.addSubview(imageView)
        textView.addSubview(textViewLabel)
        labelStack.addArrangedSubview(dateLabel)
        labelStack.addArrangedSubview(mainLabel)
        
    }
    
    private func configureConstraints() {
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
        
        textViewLabel.translatesAutoresizingMaskIntoConstraints = false
        textViewLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 10).isActive = true
//        textViewLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor).isActive = true
//        textViewLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor).isActive = true
        textViewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textViewLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
    }
    
    private func configureNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func configureTextViewLabel() {
        textViewLabel.text = "하고싶은 이야기를 입력해주세요"
        textViewLabel.isHidden = false
        textViewLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        textViewLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        textViewLabel.textAlignment = .center
    }
    
    private func configureTodayDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일"
        let now = Date()
        let dateString = formatter.string(from: now)
        return dateString
    }
    
    private func configureDefaultImageView() {
        imageView.contentMode = .center
        imageView.image = UIImage(named: "default")
        imageView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
    }
    
    private func ChangedLayout() {
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
    }
    
    // MARK: - Action Method
    @objc private func writeButtonDidTap() {
        if isHidden == true {
            scrollView.isHidden = false
            textView.isHidden = false
            imageView.isHidden = false
            clearImageViewAndTextView()
            configureTextViewLabel()
            configureDefaultImageView()
            writeButton.setTitle("기록하기", for: .normal)
            view.layoutIfNeeded()
            UIView.setAnimationsEnabled(true)
            UIView.animate(withDuration: 0.7, animations: {
                self.ChangedLayout()
            }, completion: nil)
            isHidden.toggle()
        } else {
            scrollView.isHidden = true
            textView.isHidden = true
            imageView.isHidden = true
            textView.resignFirstResponder()
            UIView.animate(withDuration: 1, animations: {
                self.writeButton.setTitle("입력하기", for: .normal)
                self.view.layoutIfNeeded()
            }, completion: nil)
            saveUserInputData()
            isHidden.toggle()
        }
    }
    
    @objc private func doneButtonClicked (_sender: Any) {
        self.view.endEditing(true)
    }
    
    @objc private func imageViewDidTap(_ sender: UIImageView) {
        var config = YPImagePickerConfiguration()
        config.startOnScreen = .library
        config.screens = [.library, .photo]
        config.showsCrop = .rectangle(ratio: 16/15)
        config.wordings.libraryTitle = "Gallery"
        config.library.maxNumberOfItems = 5
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, _ in
            
            self.selectedItems = items
            self.imageView.image = items.singlePhoto?.image
            picker.dismiss(animated: false) {
                self.showLayoutAfterUserImagePicked()
            }
        }
        present(picker, animated: false) {
            self.imagePickerCancelDidtap()
        }
    }
    
    private func saveUserInputData() {
        print("save")
        
        guard self.textView.text?.isEmpty == false else {
            let alert = UIAlertController(title: "내용을 입력해주세요.", message: "내용을 입력하지 않으면 저장이 되지 않습니다.", preferredStyle:.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
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
    
    private func showLayoutAfterUserImagePicked() {
        scrollView.isHidden = false
        textView.isHidden = false
        imageView.isHidden = false
        imageView.contentMode = .scaleAspectFit
        writeButton.setTitle("기록하기", for: .normal)
        
        ChangedLayout()
    }
    
    private func imagePickerCancelDidtap() {
        scrollView.isHidden = false
        textView.isHidden = false
        imageView.isHidden = false
        configureDefaultImageView()
        writeButton.setTitle("기록하기", for: .normal)
        
        ChangedLayout()
    }
    
    @objc private func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -150
        textViewLabel.isHidden = true
    }
    
    @objc private func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
    
    private func textViewLabelShow() {
        if textView.text?.isEmpty == true {
            configureTextViewLabel()
        } else {
            self.textViewLabel.isHidden = true
        }
    }
    
    private func clearImageViewAndTextView() {
        imageView.image = nil
        textView.text = nil
    }
    
    private func changeTheme() {
        dateLabel.textColor = Theme.dateLabel
        mainLabel.textColor = Theme.mainLabel
        writeButton.backgroundColor = Theme.writeButton
        writeButton.titleLabel?.textColor = Theme.buttonText
    }
}

// MARK: - textView delegate extension
extension ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        // 내용의 최대 10자리까지 읽어 subject 변수에 저장
        let contents = textView.text as NSString
        let length = ((contents.length > 10) ? 10 : contents.length)
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        textViewLabelShow()
        return true
    }
}

