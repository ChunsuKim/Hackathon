//
//  ForecastViewController.swift
//  TravelDiary
//
//  Created by Chunsu Kim on 28/06/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import UIKit
import CoreLocation

class ForecastViewController: UIViewController {

    // MARK: - Properties
    private let backgroundImageView = UIImageView()
    private let headerView = UIView()
    private let headerViewLocationLabel = UILabel()
    private let headerDateLabel = UILabel()
    private let refreshButton = UIButton(type: .custom)
    private let detailTableView = UITableView()
    private let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    private var topInset: CGFloat = 0.0
    
    // MARK: - Location storage and delegate
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
    
    
    // MARK: - Number Formatter setting
    private let tempFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        // 소수점이 0이면 출력하지 않고 소수점이 존재하면 1자리만 출력
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        
        return formatter
    }()
    
    // MARK: - Date Formatter setting
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "Ko_kr")
        return formatter
    }()
    
    // MARK: - App Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        headerViewLocationLabel.text = "Updating..."
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse, .authorizedAlways:
                updateCurrentLocation()
                break
            case .denied, .restricted:
                show(message: "위치 서비스 사용 불가")
            @unknown default:
                break
            }
        } else {
            show(message: "위치 서비스 사용 불가")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUserInterface()
        configureConstraints()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // topInset setting
        if topInset == 0.0 {
            let first = IndexPath(row: 0, section: 0)
            if let cell = detailTableView.cellForRow(at: first) {
                topInset = detailTableView.frame.height + (view.frame.height - 320)
                print("topInset: , \(detailTableView.frame.height)")
                print("cell for height: , \(cell.frame.height)")
                print(view.frame.height)
                detailTableView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
            }
        }
    }
    
    // MARK: - Configuration
    private func configureUserInterface() {
        configureDateFormat()
        
        // UI configuration
        backgroundImageView.image = UIImage(named: "sunny")
        headerView.backgroundColor = .clear
        headerViewLocationLabel.textColor = .white
        headerViewLocationLabel.font = UIFont.systemFont(ofSize: 20)
        headerViewLocationLabel.textAlignment = .center
        headerViewLocationLabel.text = "Label"
        refreshButton.setBackgroundImage(UIImage(named: "SKY_S00"), for: .normal)
        refreshButton.isEnabled = true
        refreshButton.addTarget(self, action: #selector(refreshButtonDidTap(_:)), for: .touchUpInside)
        
        // tableView configuration
        detailTableView.dataSource = self
        detailTableView.separatorStyle = .none
        detailTableView.allowsSelection = false
        detailTableView.delegate = self
        detailTableView.showsVerticalScrollIndicator = false
        detailTableView.backgroundColor = UIColor.clear
        blurredView.alpha = 0
        
        // Custom Cell register
        detailTableView.register(DetailHeaderTableViewCell.self, forCellReuseIdentifier: DetailHeaderTableViewCell.identifier)
        detailTableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        
        // addsubview
        view.addSubview(backgroundImageView)
        backgroundImageView.isUserInteractionEnabled = true
        backgroundImageView.addSubview(detailTableView)
        view.addSubview(headerView)
        backgroundImageView.insertSubview(blurredView, belowSubview: detailTableView)
        headerView.addSubview(headerViewLocationLabel)
        headerView.addSubview(headerDateLabel)
        headerView.addSubview(refreshButton)
        headerView.bringSubviewToFront(refreshButton)
    }
    
    private func configureConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        headerViewLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        headerViewLocationLabel.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        headerViewLocationLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor).isActive = true
        headerViewLocationLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor).isActive = true
        headerViewLocationLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        headerDateLabel.translatesAutoresizingMaskIntoConstraints = false
        headerDateLabel.topAnchor.constraint(equalTo: headerViewLocationLabel.bottomAnchor).isActive = true
        headerDateLabel.widthAnchor.constraint(equalTo: headerViewLocationLabel.widthAnchor).isActive = true
        headerDateLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        refreshButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10).isActive = true
        refreshButton.widthAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.6).isActive = true
        refreshButton.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.6).isActive = true
        
        detailTableView.translatesAutoresizingMaskIntoConstraints = false
        detailTableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        detailTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        detailTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        detailTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        blurredView.frame = self.view.bounds
        
    }
    
    // MARK: - Action and data handling Methods
    @objc private func refreshButtonDidTap(_ sender: UIButton) {
        detailTableView.reloadData()
        updateCurrentLocation()
        configureDateFormat()
        DispatchQueue.main.async {
            self.backgroundImageView.image = self.requestBackgroundImage()
        }
    }
    
    private func configureDateFormat() {
        headerDateLabel.text = "6.13 (목) 12:00"
        headerDateLabel.textAlignment = .center
        headerDateLabel.font = UIFont.systemFont(ofSize: 14)
        headerDateLabel.textColor = .white
        headerDateLabel.text = requestTodayDate()
    }
    
    private func requestTodayDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M.d (E) HH:mm"
        formatter.locale = Locale(identifier: "Ko_kr")
        let now = Date()
        let dateString = formatter.string(from: now)
        return dateString
    }
    
    private func requestBackgroundImage() -> UIImage {
        var backgroundImage = UIImage()
        if let data = WeatherDataSource.shared.summary?.weather.minutely.first {
            switch data.sky.code {
            case "SKY_A01", "SKY_A02":
                backgroundImage = UIImage(named: "sunny")! // ?? UIImage(name: "sunny")
            case "SKY_A03", "SKY_A07":
                backgroundImage = UIImage(named: "cloudy")!
            case "SKY_A04", "SKY_A05", "SKY_A06", "SKY_A08", "SKY_A09", "SKY_A10":
                backgroundImage = UIImage(named: "rainy")!
            case "SKY_A11", "SKY_A12", "SKY_A13", "SKY_A14":
                backgroundImage = UIImage(named: "lightning")!
            default:
                backgroundImage = UIImage(named: "sunny")!
            }
        }
        
        return backgroundImage
    }
    
    
}

// MARK: - TableView DataSource
extension ForecastViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return WeatherDataSource.shared.forecastList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailHeaderTableViewCell.identifier, for: indexPath) as! DetailHeaderTableViewCell
            
            if let data = WeatherDataSource.shared.summary?.weather.minutely.first {
                cell.headerCellWeatherImageView.image = UIImage(named: data.sky.code)
                cell.headerCellStatusLabel.text = data.sky.name
                
                let max = Double(data.temperature.tmax) ?? 0.0
                let min = Double(data.temperature.tmin) ?? 0.0
                
                let maxStr = tempFormatter.string(for: max) ?? "-"
                let minStr = tempFormatter.string(for: min) ?? "-"
                
                cell.headerCellMaxMintempLabel.text = "최대 \(maxStr)º   최소 \(minStr)º"
                
                let current = Double(data.temperature.tc) ?? 0.0
                let currentStr = tempFormatter.string(for: current) ?? "-"
                
                cell.headerCellThermometerLabel.text = "\(currentStr)º"
            }
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as! DetailTableViewCell
        
        let target = WeatherDataSource.shared.forecastList[indexPath.row]
        
        dateFormatter.dateFormat = "M.d (E)"
        cell.dateLabel.text = dateFormatter.string(for: target.date)
        
        dateFormatter.dateFormat = "HH:00"
        cell.timeLabel.text = dateFormatter.string(for: target.date)
        
        cell.weatherImageView.image = UIImage(named: target.skyCode)
        
        cell.statusLabel.text = target.skyName
        
        let tempStr = tempFormatter.string(for: target.temperature) ?? "-"
        cell.thermometerLabel.text = "\(tempStr)º"
        
        return cell
    }
}

// MARK: - TableView Delegate
extension ForecastViewController: UITableViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let alpha = (scrollView.contentOffset.y + detailTableView.frame.height - 320) / 300
        if alpha < 0.5 {
            blurredView.alpha = alpha
        }
    }
}

// MARK: - CLLocation Manager Delegate
extension ForecastViewController: CLLocationManagerDelegate {
    func updateCurrentLocation() {
        let status = CLLocationManager.authorizationStatus()
        guard status == .authorizedAlways || status == .authorizedWhenInUse,
            CLLocationManager.locationServicesEnabled() else { return }
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.first {
            print(loc.coordinate)
            
            let decoder = CLGeocoder()
            decoder.reverseGeocodeLocation(loc) { [weak self] (placemarks, error) in
                if let place = placemarks?.first {
                    if let gu = place.locality, let dong = place.subLocality {
                        self?.headerViewLocationLabel.text = "\(gu) \(dong)"
                    } else {
                        self?.headerViewLocationLabel.text = place.name
                    }
                }
            }
            
            WeatherDataSource.shared.fetch(location: loc) {
                self.detailTableView.reloadData()
                
                UIView.transition(with: self.backgroundImageView, duration: 1, options: [.transitionCrossDissolve], animations: {
                    
                    self.backgroundImageView.image = self.requestBackgroundImage()
                })
            }
        }
        
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        show(message: error.localizedDescription)
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            updateCurrentLocation()
        default:
            break
        }
    }
}

// MARK: - AlertController
extension UIViewController {
    func show(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
}
