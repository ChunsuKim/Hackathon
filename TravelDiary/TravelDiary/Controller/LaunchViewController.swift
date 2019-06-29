//
//  LaunchViewController.swift
//  TravelDiary
//
//  Created by JinBae Jeong on 28/06/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import UIKit

final class LaunchViewController: UIViewController {
    
    // MARK: - Properties
    private var timer = Timer()
    private let backgroundImageView = UIImageView()
    private let titleLabel = UILabel()
    private let activityIndicatorView = UIActivityIndicatorView()
    private let statusLabel = UILabel()
    private let copyRightLabel = UILabel()
    private let airplaneImage = UIImageView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        airplaneImage.image = #imageLiteral(resourceName: "airplane")
        view.addSubview(airplaneImage)
        airplaneImage.frame = CGRect(x: -150, y: 150, width: 150, height: 150)
        
        let centerOrigin = airplaneImage.center
        UIView.animateKeyframes(
            withDuration: 2,
            delay: 0.0,
            animations: {
                // 로그인 버튼을 0.4초동안 우측 아래로 이동
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1, animations: {
                    self.airplaneImage.center.x = self.view.center.x
                    self.airplaneImage.center.y = self.view.center.y
                })
        }, completion: { _ in
            self.activityIndicatorView.stopAnimating()
        })
    }
    
    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUserInterface()
        configureConstraints()
        operateActivitiIndicator()
        
        // 3초 뒤에 뷰 컨트롤러를 띄우는거
        Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { _ in
            let appDelegate =  UIApplication.shared.delegate as! AppDelegate
            let tapbar = CustomTapBarController()
            
            appDelegate.window?.rootViewController = tapbar
        }
        
//        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(presentMainView), userInfo: nil, repeats: false)
//
//        let tapBar = CustomTapBarController()
//
//        appDelegate.window?.rootViewController = tapBar
    }
    
    // MARK: - Configuration
    private func configureUserInterface() {
        backgroundImageView.image = #imageLiteral(resourceName: "Launch")
        backgroundImageView.contentMode = .scaleAspectFill
        titleLabel.text = "Travel Log"
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Snell Roundhand", size: 30)
        activityIndicatorView.color = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        statusLabel.text = "날씨정보를 받아오는 중입니다!"
        statusLabel.textColor = .white
        statusLabel.textAlignment = .center
        statusLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        copyRightLabel.text = " Copyright (c) 2019. Travelog. All rights reserved."
        copyRightLabel.textColor = #colorLiteral(red: 0.009850479662, green: 0.29078269, blue: 0.5762767196, alpha: 1)
        copyRightLabel.textAlignment = .center
        copyRightLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        view.addSubview(backgroundImageView)
        backgroundImageView.addSubview(titleLabel)
        backgroundImageView.addSubview(activityIndicatorView)
        backgroundImageView.addSubview(statusLabel)
        backgroundImageView.addSubview(copyRightLabel)
    }
    
    private func configureConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor, constant: 200).isActive = true
        activityIndicatorView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        activityIndicatorView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.topAnchor.constraint(equalTo: activityIndicatorView.bottomAnchor, constant: 10).isActive = true
        statusLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor).isActive = true
        statusLabel.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor).isActive = true
        statusLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        copyRightLabel.translatesAutoresizingMaskIntoConstraints = false
        copyRightLabel.leadingAnchor.constraint(equalTo: backgroundImageView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        copyRightLabel.trailingAnchor.constraint(equalTo: backgroundImageView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        copyRightLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        copyRightLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
    }
    
    private func operateActivitiIndicator() {
        
        activityIndicatorView.startAnimating()
        
    }
    
    // MARK: - Action Methods
    @objc private func presentMainView() {
        timer.invalidate()
        let viewController = MainViewController()
        
        present(viewController, animated: true)
        activityIndicatorView.stopAnimating()
        activityIndicatorView.hidesWhenStopped = true
    }
}
