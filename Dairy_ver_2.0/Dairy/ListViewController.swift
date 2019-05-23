//
//  ListViewController.swift
//  Dairy
//
//  Created by 차수연 on 21/05/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var subject = UILabel()
    var registerDate = UILabel()
  
  var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return collectionView
    
  }()
    
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addSubview()
    autoLayout()
    configure()
    
  }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
  
  private func addSubview() {
    view.addSubview(collectionView)
//    view.addSubview(subject)
//    view.addSubview(registerDate)
  }
  
  private func autoLayout() {
    let guide = view.safeAreaLayoutGuide
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
    collectionView.centerYAnchor.constraint(equalTo: guide.centerYAnchor).isActive = true
    collectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    collectionView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.9).isActive = true
    
  }
  
  private func configure() {
    collectionView.backgroundColor = .white
    
    collectionView.dataSource = self
    collectionView.delegate = self
    
    collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
    
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.isPagingEnabled = true
    
    
  }
}

extension ListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    let count = self.appDelegate.memolist.count
    return count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
    
    // memolist 배열 데이터에서 주어진 행에 맞는 데이터를 꺼냄
    let row = self.appDelegate.memolist[indexPath.row]
    // 이미지 속성이 비어 있을 경우 "memoCell", 아니면 "memoCellwithImage"
//    let cellId = row.image == nil ? "memoCell" : "memoCellWithImage"
    // 재사용 큐로부터 프로토타입 셀의 인스턴스를 전달받는다
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
    // memoCell의 내용을 구성
    cell.subject.text = row.title
    
    // Date 타입의 날짜 포맷지정
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    cell.registerDate.text = formatter.string(from: row.registerDate!)
    return cell
  }
}

extension ListViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let detailVC = DetailViewController()
    let row = self.appDelegate.memolist[indexPath.row]
    detailVC.savedData = row
    show(detailVC, sender: nil)
  }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: view.frame.width, height: view.frame.width)
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
    
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
    
    return 0
  }
  
  //셀 사이의 간격
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
    
    return 0
  }
}
