//
//  SettingViewController.swift
//  DayByDay
//
//  Created by Chunsu Kim on 23/05/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
  
  let tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addSubview()
    autoLayout()
    configure()
  }
  
  func addSubview() {
    view.addSubview(tableView)
    
    
  }
  
  func autoLayout() {
    let guide = view.safeAreaLayoutGuide
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
    
  }
  
  func configure() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }
  
  
  
}
extension SettingViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Thema.num
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = "\(indexPath.row)"
    return cell
  }
  
  
}

extension SettingViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
      Thema.Thema1()
      
      tabBarController?.tabBar.tintColor = Thema.tabBarTint
      tabBarController?.tabBar.barTintColor = Thema.tabBarBarTint
    case 1:
      Thema.Thema2()
      
      tabBarController?.tabBar.tintColor = Thema.tabBarTint
      tabBarController?.tabBar.barTintColor = Thema.tabBarBarTint
    case 2:
      Thema.Thema3()
      
      tabBarController?.tabBar.tintColor = Thema.tabBarTint
      tabBarController?.tabBar.barTintColor = Thema.tabBarBarTint
    default:
      break
    }
  }
}
