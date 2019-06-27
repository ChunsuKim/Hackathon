//
//  WriteViewController.swift
//  TravelDiary
//
//  Created by Chunsu Kim on 25/06/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import UIKit
import YPImagePicker
import Photos

class WriteViewController: UIViewController {
    
    var datePicker : UIDatePicker!
    
    var sDate = Date()
    var eDate = Date()
    
    private let topNavigationView = UIView()
    private let backButton = UIButton()
    private let saveButton = UIButton()
    private let scrollView = UIScrollView()
    private let textView = UITextView()
    private let textViewLabel = UILabel()
    let selectedImageView = UIImageView()
    
    let dateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let firstDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "여행시작 :"
        
        return label
    }()
    
    let firstDateTF: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "01 Jan 2019"
        
        return textField
    }()
    
    let lastDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "여행끝 :"
        
        return label
    }()
    
    let lastDateTF: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "01 Jan 2019"
        
        return textField
    }()
    
    let locationTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "여행지 :"
        
        return label
    }()
    
    let location: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "여행지를 선택해주세요"
        
        return label
    }()
  
    var subject: String?
    var selectedItems = [YPMediaItem]()
    lazy var dao = MemoDAO()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        configureCustomKeyboard()
        configureConstraints()
        configureNotificationForKeyboard()
    }
    
    private func configureViews() {
        view.backgroundColor = .white
        topNavigationView.backgroundColor = .white
        selectedImageView.contentMode = .scaleAspectFit
        selectedImageView.image = UIImage(named: "IU")
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewDidTap(_:)))
        selectedImageView.isUserInteractionEnabled = true
        selectedImageView.addGestureRecognizer(imageTapGesture)
        
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonDidTap(_:)), for: .touchUpInside)
        
        saveButton.setImage(UIImage(named: "save"), for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonDidTap(_:)), for: .touchUpInside)
        
        firstDateTF.delegate = self
        lastDateTF.delegate = self
        textView.delegate = self
        textView.font = UIFont.italicSystemFont(ofSize: 20)
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.layer.borderColor = #colorLiteral(red: 0.5004553199, green: 0.6069974899, blue: 1, alpha: 1)
        textView.clipsToBounds = true
        
        configureTextViewLabel()
        
        view.addSubview(topNavigationView)
        topNavigationView.addSubview(backButton)
        topNavigationView.addSubview(saveButton)
        view.addSubview(scrollView)
        scrollView.addSubview(selectedImageView)
        scrollView.addSubview(textView)
        scrollView.addSubview(dateView)
        dateView.addSubview(firstDateLabel)
        dateView.addSubview(firstDateTF)
        dateView.addSubview(lastDateLabel)
        dateView.addSubview(lastDateTF)
        dateView.addSubview(locationTitle)
        dateView.addSubview(location)

        textView.addSubview(textViewLabel)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapFunction(_:)))
        location.addGestureRecognizer(tapGesture)
        location.isUserInteractionEnabled = true
    }
    
    private func configureCustomKeyboard() {
        let toolBarKeyboard = UIToolbar()
        toolBarKeyboard.sizeToFit()
        let buttonflexBar = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let buttonDoneBar = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(self.doneButtonClicked(_sender:)))
        toolBarKeyboard.items = [buttonflexBar, buttonDoneBar]
        toolBarKeyboard.tintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        textView.inputAccessoryView = toolBarKeyboard
        textView.keyboardAppearance = UIKeyboardAppearance.dark
    }
    
    private func configureTextViewLabel() {
        textViewLabel.text = "소중한 추억을 적어주세요 🧐"
        textViewLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        textViewLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        textViewLabel.textAlignment = .center
        textViewLabel.isHidden = false
    }
    
    func pickUpDate(_ textField : UITextField){
        
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor.white
        self.datePicker.datePickerMode = .date
        textField.inputView = self.datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    @objc func doneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        if firstDateTF.isEditing {
            sDate = datePicker.date
            firstDateTF.text = dateFormatter1.string(from: datePicker.date)
            firstDateTF.resignFirstResponder()
            
            let startDate = sDate
            let endDate = eDate
            let diffDate = endDate.timeIntervalSince(startDate)
            let days = Int(diffDate / 86400)
            print("\(days)일만큼 차이납니다.")
        } else {
            eDate = datePicker.date
            lastDateTF.text = dateFormatter1.string(from: datePicker.date)
            lastDateTF.resignFirstResponder()
            
            let startDate = sDate
            let endDate = eDate
            let diffDate = endDate.timeIntervalSince(startDate)
            let days = Int(diffDate / 86400)
            print("\(days)일만큼 차이납니다.")
        }
    }
    @objc func cancelClick() {
        if firstDateTF.isEditing {
            firstDateTF.resignFirstResponder()
        } else {
            lastDateTF.resignFirstResponder()
        }
    }
    
    private func configureNotificationForKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func configureConstraints() {
        topNavigationView.translatesAutoresizingMaskIntoConstraints = false
        topNavigationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topNavigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topNavigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topNavigationView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.centerYAnchor.constraint(equalTo: topNavigationView.safeAreaLayoutGuide.centerYAnchor).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.leadingAnchor.constraint(equalTo: topNavigationView.leadingAnchor, constant: 20).isActive = true
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.centerYAnchor.constraint(equalTo: topNavigationView.safeAreaLayoutGuide.centerYAnchor).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: topNavigationView.trailingAnchor, constant: -20).isActive = true
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topNavigationView.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        selectedImageView.translatesAutoresizingMaskIntoConstraints = false
        selectedImageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        selectedImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        selectedImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        selectedImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45).isActive = true
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: dateView.bottomAnchor, constant: 10).isActive = true
        textView.centerXAnchor.constraint(equalTo: dateView.centerXAnchor).isActive = true
        textView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 600).isActive = true
        textView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10).isActive = true
        
        textViewLabel.translatesAutoresizingMaskIntoConstraints = false
        textViewLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 10).isActive = true
        textViewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textViewLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        dateView.topAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: 10).isActive = true
        dateView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dateView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        dateView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        firstDateLabel.topAnchor.constraint(equalTo: dateView.topAnchor).isActive = true
        firstDateLabel.leadingAnchor.constraint(equalTo: dateView.leadingAnchor).isActive = true
        firstDateTF.topAnchor.constraint(equalTo: dateView.topAnchor).isActive = true
        firstDateTF.leadingAnchor.constraint(equalTo: firstDateLabel.trailingAnchor, constant: 10).isActive = true
        lastDateLabel.topAnchor.constraint(equalTo: dateView.topAnchor).isActive = true
        lastDateLabel.leadingAnchor.constraint(equalTo: firstDateTF.trailingAnchor, constant: 15).isActive = true
        lastDateTF.topAnchor.constraint(equalTo: dateView.topAnchor).isActive = true
        lastDateTF.leadingAnchor.constraint(equalTo: lastDateLabel.trailingAnchor, constant: 10).isActive = true
        locationTitle.bottomAnchor.constraint(equalTo: dateView.bottomAnchor).isActive = true
        locationTitle.leadingAnchor.constraint(equalTo: dateView.leadingAnchor).isActive = true
        location.bottomAnchor.constraint(equalTo: dateView.bottomAnchor).isActive = true
        location.leadingAnchor.constraint(equalTo: locationTitle.trailingAnchor, constant: 10).isActive = true
    }
    
    private func textViewLabelShow() {
        if textView.text?.isEmpty == true {
            configureTextViewLabel()
        } else {
            self.textViewLabel.isHidden = true
        }
    }
    
    private func saveUserInputData() {
        print("save")
        
        guard
            self.textView.text?.isEmpty == false &&
            self.firstDateTF.text?.isEmpty == false &&
            self.lastDateTF.text?.isEmpty == false else {
            let alert = UIAlertController(title: "내용을 입력해주세요", message: "내용을 입력하지 않으면 저장이 되지 않습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        // MemoData 객체를 생성, 데이터를 담는다
        let data = MemoData()
        
        data.title = self.subject
        data.contents = self.textView.text
        data.image = self.selectedImageView.image
        data.registerDate = Date()
        data.sDate = sDate
        data.eDate = eDate
        
        self.dao.insert(data)
    }
    
    @objc private func imageViewDidTap(_ sender: UIImageView) {
        var config = YPImagePickerConfiguration()
        config.startOnScreen = .library
        config.screens = [.library, .photo]
//        config.showsCrop = .rectangle(ratio: 16/15)
        config.wordings.libraryTitle = "Travel Log"
        config.library.maxNumberOfItems = 5
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, _ in
            
            self.selectedItems = items
            self.selectedImageView.image = items.singlePhoto?.image
            picker.dismiss(animated: false)
        }
        present(picker, animated: false)
    }
    
    @objc private func backButtonDidTap(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc private func saveButtonDidTap(_ sender: UIButton) {
        saveUserInputData()
    }
    
    @objc private func doneButtonClicked (_sender: Any) {
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -300
        textViewLabel.isHidden = true
    }
    
    @objc private func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
    
    @objc func tapFunction(_ sender:UITapGestureRecognizer) {
        let mapVC = MapViewController()
        present(mapVC, animated: true)
    }

}

extension WriteViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
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

extension WriteViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if firstDateTF.isEditing {
            self.pickUpDate(self.firstDateTF)
        } else {
            self.pickUpDate(self.lastDateTF)
        }
    }
}
