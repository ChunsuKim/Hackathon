//
//  ListViewController.swift
//  DayByDay
//
//  Created by Chunsu Kim on 23/05/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
  
    // MARK: - Properties
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var dao = MemoDAO()
    
    let topView = UIView()
    let userImageView = UIImageView()
    let userMessageLabel = UILabel()
    let searchController = UISearchController(searchResultsController: nil)
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    var tempColor: UIColor = #colorLiteral(red: 0.4621340632, green: 0.8370614648, blue: 1, alpha: 1)
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUserInterface()
        configureConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 코어 데이터에 저장된 데이터를 가져온다
        self.appDelegate.memolist = self.dao.fetch()
        let state = UserDefaults.standard.object(forKey: "state")
        userMessageLabel.text = state as? String
        self.collectionView.reloadData()
    }
    
    // MARK: - configuration
    private func configureUserInterface() {
        let settingVC = SettingViewController()
        
        userMessageLabel.backgroundColor = .white
        userMessageLabel.textColor = .black
        userMessageLabel.text = settingVC.userMessageLabel.text
        userMessageLabel.textAlignment = .center
        
        collectionView.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        
        userImageView.layer.borderWidth = 1
        userImageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        userImageView.layer.cornerRadius = 50
        userImageView.clipsToBounds = true
        userImageView.image = UIImage(named: "user")
        
        
        userMessageLabel.textColor = .black
        userMessageLabel.backgroundColor = .white
        userMessageLabel.textAlignment = .center
        userMessageLabel.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        userMessageLabel.layer.borderWidth = 1
        userMessageLabel.layer.cornerRadius = 10
        userMessageLabel.clipsToBounds = true
        
        view.addSubview(collectionView)
        view.addSubview(topView)
        topView.addSubview(userMessageLabel)
        topView.addSubview(userImageView)
    }
    
    private func configureConstraints() {
        let guide = view.safeAreaLayoutGuide
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        topView.bottomAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        
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
        
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.8).isActive = true
        
    }
}

// MARK: - collectionView dataSource extension
extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let count = self.appDelegate.memolist.count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // memolist 배열 데이터에서 주어진 행에 맞는 데이터를 꺼냄
        let item = self.appDelegate.memolist[indexPath.item]
        // 이미지 속성이 비어 있을 경우 "memoCell", 아니면 "memoCellwithImage"
        //    let cellId = row.image == nil ? "memoCell" : "memoCellWithImage"
        // 재사용 큐로부터 프로토타입 셀의 인스턴스를 전달받는다
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        // memoCell의 내용을 구성
        cell.subject.text = item.title
        cell.view.tag = indexPath.item
        cell.delegate = self
        cell.view.backgroundColor = tempColor
        
        // Date 타입의 날짜 포맷지정
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.registerDate.text = formatter.string(from: item.registerDate!)
        return cell
    }
}

// MARK: - collectionView delegate extension
extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        let item = self.appDelegate.memolist[indexPath.item]
        detailVC.savedData = item
        detailVC.title = self.appDelegate.memolist[indexPath.item].title
        show(detailVC, sender: nil)
    }
    
}

// MARK: - collectionView delegate flowLayout extension
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

// MARK: - collectionView cell delegate extension
extension ListViewController: CustomCollectionViewCellDelegate {
    
    func removeCell(_ sender: Int) {
        let data = self.appDelegate.memolist[sender]
        
        let alertAction = UIAlertController(title: "정말 삭제하실 건가요?", message: "삭제 후에는 복구 할 수 없습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "삭제하기", style: .destructive) { (_) in
            if self.dao.delete(data.objectID!) {
                self.appDelegate.memolist.remove(at: sender)
            }
            self.collectionView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alertAction.addAction(okAction)
        alertAction.addAction(cancelAction)
        present(alertAction, animated: true)
        
    }
}
