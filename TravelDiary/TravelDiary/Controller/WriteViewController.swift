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
    
    // MARK: - Properties
    private let topNavigationView = UIView()
    private let backButton = UIButton()
    private let saveButton = UIButton()
    private let topLabel = UILabel()
    
    private let scrollView = UIScrollView()
    private let selectedImageView = UIImageView()
    private let infoImageViewLabel = UILabel()
    
    private let dateView = UIView()
    private var datePicker : UIDatePicker!
    private var sDate = Date()
    private var eDate = Date()
    private let firstDateLabel = UILabel()
    private let firstDateTextField = UITextField()
    private let lastDateLabel = UILabel()
    private let lastDateTextField = UITextField()
    private let locationTitleLabel = UILabel()
    let locationLabel = UILabel()
    private let mapButton = UIButton(type: .system)
    
    private let textView = UITextView()
    private let textViewLabel = UILabel()
    
    var subject: String?
    var selectedItems = [YPMediaItem]()
    lazy var dao = MemoDAO()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        configureCustomKeyboard()
        configureConstraints()
        configureNotificationForKeyboard()
    }
    
    // MARK: - configuration User Interface
    private func configureViews() {
        // View configuration
        view.backgroundColor = .white
        
        // Top navigation view configuration
        topNavigationView.backgroundColor = .white
        backButton.setImage(UIImage(named: "reset"), for: .normal)
        backButton.addTarget(self, action: #selector(resetButtonDidTap(_:)), for: .touchUpInside)
        
        saveButton.setImage(UIImage(named: "save"), for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonDidTap(_:)), for: .touchUpInside)
        
        topLabel.text = "Write your travel log"
        topLabel.textAlignment = .center
        topLabel.font = UIFont(name: "Snell Roundhand", size: 30)
        topLabel.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        // ImageView configuration
        selectedImageView.contentMode = .scaleAspectFit
        selectedImageView.image = UIImage(named: "IU")
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(touchGestureForImageView(_:)))
        selectedImageView.isUserInteractionEnabled = true
        selectedImageView.addGestureRecognizer(imageTapGesture)
        
        infoImageViewLabel.text = "IU님 사진을 터치하시면 이미지를 넣을 수 있습니다."
        infoImageViewLabel.textColor = #colorLiteral(red: 0.5004553199, green: 0.6069974899, blue: 1, alpha: 1)
        infoImageViewLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        infoImageViewLabel.textAlignment = .center
        
        // Related Date and Location UserInterface configuration
        firstDateLabel.text = "여행시작 :"
        lastDateLabel.text = "여행끝 :"
        firstDateTextField.placeholder = "01 Jan 2019"
        firstDateTextField.delegate = self
        lastDateTextField.placeholder = "01 Jan 2019"
        lastDateTextField.delegate = self
        locationTitleLabel.text = "여행지 :"
        locationLabel.text = "여행지를 선택해주세요"
        mapButton.setBackgroundImage(#imageLiteral(resourceName: "map"), for: .normal)
        mapButton.addTarget(self, action: #selector(mapButtonDidTap(_:)), for: .touchUpInside)
        
        // TextView configuration
        textView.delegate = self
        textView.font = UIFont.italicSystemFont(ofSize: 20)
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.layer.borderColor = #colorLiteral(red: 0.5004553199, green: 0.6069974899, blue: 1, alpha: 1)
        textView.clipsToBounds = true
        
        configureTextViewLabel()
//        locationLabelInputText()
        
        // addSubview
        view.addSubview(topNavigationView)
        topNavigationView.addSubview(backButton)
        topNavigationView.addSubview(saveButton)
        topNavigationView.addSubview(topLabel)
        
        view.addSubview(scrollView)
        scrollView.addSubview(selectedImageView)
        selectedImageView.addSubview(infoImageViewLabel)
        
        scrollView.addSubview(dateView)
        dateView.addSubview(firstDateLabel)
        dateView.addSubview(firstDateTextField)
        dateView.addSubview(lastDateLabel)
        dateView.addSubview(lastDateTextField)
        dateView.addSubview(locationTitleLabel)
        dateView.addSubview(locationLabel)
        dateView.addSubview(mapButton)
        
        scrollView.addSubview(textView)
        textView.addSubview(textViewLabel)
    }
    
    private func configureCustomKeyboard() {
        let toolBarKeyboard = UIToolbar()
        toolBarKeyboard.sizeToFit()
        let buttonflexBar = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let buttonDoneBar = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(self.keyboardDoneButtonClicked(_sender:)))
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
    
    private func configureConstraints() {
        
        // Top navigation view configure constraints
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
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.centerYAnchor.constraint(equalTo: topNavigationView.safeAreaLayoutGuide.centerYAnchor).isActive = true
        topLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor).isActive = true
        topLabel.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.centerYAnchor.constraint(equalTo: topNavigationView.safeAreaLayoutGuide.centerYAnchor).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: topNavigationView.trailingAnchor, constant: -20).isActive = true
        
        // ImageView configure constraints
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
        
        infoImageViewLabel.translatesAutoresizingMaskIntoConstraints = false
        infoImageViewLabel.topAnchor.constraint(equalTo: selectedImageView.topAnchor).isActive = true
        infoImageViewLabel.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor).isActive = true
        infoImageViewLabel.trailingAnchor.constraint(equalTo: selectedImageView.trailingAnchor).isActive = true
        infoImageViewLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Related Date and Location UserInterface configure constraints
        dateView.translatesAutoresizingMaskIntoConstraints = false
        dateView.topAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: 10).isActive = true
        dateView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dateView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        dateView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        firstDateLabel.translatesAutoresizingMaskIntoConstraints = false
        firstDateLabel.topAnchor.constraint(equalTo: dateView.topAnchor).isActive = true
        firstDateLabel.leadingAnchor.constraint(equalTo: dateView.leadingAnchor).isActive = true
        
        firstDateTextField.translatesAutoresizingMaskIntoConstraints = false
        firstDateTextField.topAnchor.constraint(equalTo: dateView.topAnchor).isActive = true
        firstDateTextField.leadingAnchor.constraint(equalTo: firstDateLabel.trailingAnchor, constant: 10).isActive = true
        
        lastDateLabel.translatesAutoresizingMaskIntoConstraints = false
        lastDateLabel.topAnchor.constraint(equalTo: dateView.topAnchor).isActive = true
        lastDateLabel.leadingAnchor.constraint(equalTo: firstDateTextField.trailingAnchor, constant: 15).isActive = true
        
        lastDateTextField.translatesAutoresizingMaskIntoConstraints = false
        lastDateTextField.topAnchor.constraint(equalTo: dateView.topAnchor).isActive = true
        lastDateTextField.leadingAnchor.constraint(equalTo: lastDateLabel.trailingAnchor, constant: 10).isActive = true
        
        locationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        locationTitleLabel.bottomAnchor.constraint(equalTo: dateView.bottomAnchor).isActive = true
        locationTitleLabel.leadingAnchor.constraint(equalTo: dateView.leadingAnchor).isActive = true
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.bottomAnchor.constraint(equalTo: dateView.bottomAnchor).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: locationTitleLabel.trailingAnchor, constant: 10).isActive = true
        
        mapButton.translatesAutoresizingMaskIntoConstraints = false
        mapButton.centerYAnchor.constraint(equalTo: locationLabel.centerYAnchor).isActive = true
        mapButton.leadingAnchor.constraint(equalTo: locationLabel.trailingAnchor, constant: 10).isActive = true
        mapButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        mapButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // TextView configure constraints
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
    }
    
    private func pickUpDate(_ textField : UITextField){
        
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
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(datePickerDoneButtonDidTap))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(datePickerCancelButtonDidTap))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    private func configureNotificationForKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func textViewLabelShow() {
        if textView.text?.isEmpty == true {
            configureTextViewLabel()
        } else {
            self.textViewLabel.isHidden = true
        }
    }
    
    private func showImageViewLabelInitialConfiguration() {
        infoImageViewLabel.text = "IU님 사진을 터치하시면 이미지를 넣을 수 있습니다."
        infoImageViewLabel.textColor = #colorLiteral(red: 0.5004553199, green: 0.6069974899, blue: 1, alpha: 1)
        infoImageViewLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        infoImageViewLabel.textAlignment = .center
        infoImageViewLabel.isHidden = false
    }
    
    private func hideImageViewLabel() {
        infoImageViewLabel.isHidden = true
    }
    
    private func saveUserInputData() {
        print("save")
        
        guard
            self.textView.text?.isEmpty == false &&
            self.firstDateTextField.text?.isEmpty == false &&
            self.lastDateTextField.text?.isEmpty == false else {
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
        data.location = locationLabel.text
        data.sDate = sDate
        data.eDate = eDate
        
        self.dao.insert(data)
    }
    
    // MARK: - Action Methods
    @objc private func touchGestureForImageView(_ sender: UIImageView) {
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
            picker.dismiss(animated: false) {
                self.hideImageViewLabel()
            }
        }
        present(picker, animated: true) {
            self.showImageViewLabelInitialConfiguration()
        }
    }
    
    @objc private func resetButtonDidTap(_ sender: UIButton) {
        self.selectedImageView.image = UIImage(named: "IU")
        self.textView.text = nil
        self.firstDateTextField.text = nil
        self.lastDateTextField.text = nil
        self.locationLabel.text = "여행지를 선택해주세요"
        infoImageViewLabel.isHidden = false
    }
    
    @objc private func saveButtonDidTap(_ sender: UIButton) {
        saveUserInputData()
        
        // create the alert
        let alert = UIAlertController(title: "포스팅 되었습니다.", message: nil, preferredStyle: .alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            let tabbar = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController
            tabbar?.selectedIndex = 0
        }))
        self.present(alert, animated: true) {
            self.selectedImageView.image = UIImage(named: "IU")
            self.textView.text = nil
            self.firstDateTextField.text = nil
            self.lastDateTextField.text = nil
            self.locationLabel.text = "여행지를 선택해주세요"
        }
    }
    
    @objc private func keyboardDoneButtonClicked (_sender: Any) {
        self.view.endEditing(true)
    }
    
    @objc private func datePickerDoneButtonDidTap() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        if firstDateTextField.isEditing {
            sDate = datePicker.date
            firstDateTextField.text = dateFormatter1.string(from: datePicker.date)
            firstDateTextField.resignFirstResponder()
            
            let startDate = sDate
            let endDate = eDate
            let diffDate = endDate.timeIntervalSince(startDate)
            let days = Int(diffDate / 86400)
            print("\(days)일만큼 차이납니다.")
        } else {
            eDate = datePicker.date
            lastDateTextField.text = dateFormatter1.string(from: datePicker.date)
            lastDateTextField.resignFirstResponder()
            
            let startDate = sDate
            let endDate = eDate
            let diffDate = endDate.timeIntervalSince(startDate)
            let days = Int(diffDate / 86400)
            print("\(days)일만큼 차이납니다.")
        }
    }
    
    @objc private func datePickerCancelButtonDidTap() {
        if firstDateTextField.isEditing {
            firstDateTextField.resignFirstResponder()
        } else {
            lastDateTextField.resignFirstResponder()
        }
    }
    
    @objc private func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -300
        textViewLabel.isHidden = true
    }
    
    @objc private func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
    
    @objc func mapButtonDidTap(_ sender: UIButton) {
        let mapVC = MapViewController()
        present(mapVC, animated: true)
    }

}

// MARK: - extension textView Delegate
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

// MARK: - extension textField Delegate
extension WriteViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if firstDateTextField.isEditing {
            self.pickUpDate(self.firstDateTextField)
        } else {
            self.pickUpDate(self.lastDateTextField)
        }
    }
}
