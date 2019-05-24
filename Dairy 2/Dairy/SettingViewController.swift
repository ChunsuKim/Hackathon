//
//  SettingViewController.swift
//  Dairy
//
//  Created by 차수연 on 20/05/2019.
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
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.delegate = self
  }

}

extension SettingViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = "테마\(indexPath.row + 1)"
    cell.tag = indexPath.row + 1

    return cell
  }
  
  
}

extension SettingViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
    
  }
}
