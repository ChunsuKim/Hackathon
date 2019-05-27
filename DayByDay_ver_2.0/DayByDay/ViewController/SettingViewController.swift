//
//  SettingViewController.swift
//  DayByDay
//
//  Created by Chunsu Kim on 23/05/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
  
  let topView = UIView()
  let userImageView = UIImageView()
  let userMessageLabel = UILabel()
  let userUpdateButton = UIButton(type: .system)
  let tableView = UITableView()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addSubview()
    autoLayout()
    configure()
  }
  
      override func viewWillAppear(_ animated: Bool) {
        let state = UserDefaults.standard.object(forKey: "state")
        userMessageLabel.text = state as? String
  }
  
  
  func addSubview() {
    view.addSubview(topView)
    view.addSubview(tableView)
    
    topView.addSubview(userImageView)
    topView.addSubview(userMessageLabel)
    topView.addSubview(userUpdateButton)
    
  }
  
  func autoLayout() {
    let guide = view.safeAreaLayoutGuide
    
    topView.translatesAutoresizingMaskIntoConstraints = false
    topView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
    topView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    topView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    topView.bottomAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
    
    userImageView.translatesAutoresizingMaskIntoConstraints = false
    userImageView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 20).isActive = true
    userImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 5).isActive = true
    userImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    userImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    
    userMessageLabel.translatesAutoresizingMaskIntoConstraints = false
    userMessageLabel.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor).isActive = true
    userMessageLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10).isActive = true
    userMessageLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    userMessageLabel.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.7).isActive = true
    
    userUpdateButton.translatesAutoresizingMaskIntoConstraints = false
    userUpdateButton.topAnchor.constraint(equalTo: userMessageLabel.bottomAnchor).isActive = true
    userUpdateButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10).isActive = true
    userUpdateButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    userUpdateButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
    tableView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.8).isActive = true
  }
  
  func configure() {
    topView.backgroundColor = .white
    
    userImageView.layer.borderWidth = 1
    userImageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    userImageView.layer.cornerRadius = 50
    userImageView.clipsToBounds = true
    userImageView.image = UIImage(named: "user")
    
    userMessageLabel.backgroundColor = .white
    userMessageLabel.textAlignment = .center
    userMessageLabel.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    userMessageLabel.layer.borderWidth = 1
    userMessageLabel.layer.cornerRadius = 10
    userMessageLabel.clipsToBounds = true
    
    userUpdateButton.setTitle("상태메시지 수정", for: .normal)
    userUpdateButton.addTarget(self, action: #selector(diduserUpdateButtonDidTap(_:)), for: .touchUpInside)
    
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }
  
  @objc func diduserUpdateButtonDidTap(_ sender: UIButton) {
    alertAction()
  }
    
  func alertAction() {
    
    let alert = UIAlertController(title: "수정", message: "", preferredStyle: .alert)
    alert.addTextField { (tf) in
      tf.placeholder = "내용을 입력하세요."
        
    }
    let okAction = UIAlertAction(title: "수정하기", style: .default) { (_) in

      if let typingSomething = alert.textFields?[0].text {
        self.userMessageLabel.text = typingSomething
        UserDefaults.standard.set(typingSomething, forKey: "state")
        
      }
      print("수정하기")
    }
    let cancelAction = UIAlertAction(title: "취소", style: .cancel)
    
    alert.addAction(okAction)
    alert.addAction(cancelAction)
    self.present(alert, animated: true)
  }
}

extension SettingViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "테마"
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return themeName.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = themeName[indexPath.row]
    return cell
  }
  
  
}

extension SettingViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
      Theme.defaultTheme()
      
      tabBarController?.tabBar.tintColor = Theme.tabBarBarTint
      tabBarController?.tabBar.barTintColor = Theme.tabBarTint
        tabBarController?.tabBar.unselectedItemTintColor = Theme.tabBarUnselectedTintColor
    case 1:
      Theme.darkBlueTheme()
      
      tabBarController?.tabBar.tintColor = Theme.tabBarBarTint
      tabBarController?.tabBar.barTintColor = Theme.tabBarTint
        tabBarController?.tabBar.unselectedItemTintColor = Theme.tabBarUnselectedTintColor
    case 2:
      Theme.pinkTheme()
      
      tabBarController?.tabBar.tintColor = Theme.tabBarBarTint
      tabBarController?.tabBar.barTintColor = Theme.tabBarTint
        tabBarController?.tabBar.unselectedItemTintColor = Theme.tabBarUnselectedTintColor
    case 3:
        Theme.violetTheme()
        
        tabBarController?.tabBar.tintColor = Theme.tabBarBarTint
        tabBarController?.tabBar.barTintColor = Theme.tabBarTint
        tabBarController?.tabBar.unselectedItemTintColor = Theme.tabBarUnselectedTintColor
    case 4:
        Theme.greenTheme()
        
        tabBarController?.tabBar.tintColor = Theme.tabBarBarTint
        tabBarController?.tabBar.barTintColor = Theme.tabBarTint
        tabBarController?.tabBar.unselectedItemTintColor = Theme.tabBarUnselectedTintColor
    case 5:
        Theme.grayTheme()
        
        tabBarController?.tabBar.tintColor = Theme.tabBarBarTint
        tabBarController?.tabBar.barTintColor = Theme.tabBarTint
        tabBarController?.tabBar.unselectedItemTintColor = Theme.tabBarUnselectedTintColor
    case 6:
        Theme.yellowTheme()
        
        tabBarController?.tabBar.tintColor = Theme.tabBarBarTint
        tabBarController?.tabBar.barTintColor = Theme.tabBarTint
        tabBarController?.tabBar.unselectedItemTintColor = Theme.tabBarUnselectedTintColor
    default:
      break
    }
  }
}
