//
//  MapViewController.swift
//  TravelDiary
//
//  Created by JinBae Jeong on 28/06/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import CoreLocation
import MapKit
import UIKit

class MapViewController: UIViewController {
    
    // MARK: - Properties
    lazy var tempLocation = ""
    
    private let textFiled = UITextField()
    private let removeButton = UIButton(type: .system)
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "backCus"), for: .normal)
        
        return button
    }()
    private let checkButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "check"), for: .normal)
        
        return button
    }()
    private var mapView = MKMapView()
    private var exPoint: [CLLocationCoordinate2D] = []
    private let locationManager = CLLocationManager()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMapView()
        configureConstraints()
        checkAuthorizationStatus()
        
    }
    
    // MARK: - configuration MapView
    private func configureMapView() {
        view.backgroundColor = .white
        textFiled.font = UIFont.systemFont(ofSize: 20)
        textFiled.textAlignment = .left
        textFiled.backgroundColor = .white
        textFiled.textColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        textFiled.borderStyle = .roundedRect
        textFiled.placeholder = "Please, typing Address"
        textFiled.keyboardAppearance = UIKeyboardAppearance.dark
        textFiled.clearButtonMode = UITextField.ViewMode.always
        textFiled.enablesReturnKeyAutomatically = true
        textFiled.addTarget(self, action: #selector(textFieldShouldReturn(_:)), for: .editingDidEndOnExit)
        
        dismissButton.addTarget(self, action: #selector(dismissButtonEvent(_:)), for: .touchUpInside)
        checkButton.addTarget(self, action: #selector(checkButtonEvent(_:)), for: .touchUpInside)
        
        removeButton.setTitle("Remove", for: .normal)
        removeButton.setTitleColor(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), for: .normal)
        removeButton.addTarget(self, action: #selector(removeOverlays(_:)), for: .touchUpInside)
        
        mapView.mapType = .standard
        mapView.showsCompass = true
        
        mapView.addSubview(removeButton)
        view.addSubview(mapView)
        view.addSubview(textFiled)
        view.addSubview(dismissButton)
        view.addSubview(checkButton)
        
    }
    
    private func checkAuthorizationStatus() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedWhenInUse:
            fallthrough
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    private func configureConstraints() {
        dismissButton.centerYAnchor.constraint(equalTo: textFiled.centerYAnchor).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        dismissButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        
        textFiled.translatesAutoresizingMaskIntoConstraints = false
        textFiled.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        textFiled.leadingAnchor.constraint(equalTo: dismissButton.trailingAnchor, constant: 10).isActive = true
        textFiled.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        checkButton.centerYAnchor.constraint(equalTo: textFiled.centerYAnchor).isActive = true
        checkButton.leadingAnchor.constraint(equalTo: textFiled.trailingAnchor, constant: 10).isActive = true
        checkButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        checkButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        checkButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.topAnchor.constraint(equalTo: textFiled.bottomAnchor).isActive = true
        removeButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        removeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        removeButton.centerXAnchor.constraint(equalTo: textFiled.centerXAnchor).isActive = true
    }
    
    private func setRegion(coordinate: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        exPoint.append(coordinate)
        addAnnotation(coordinate)
        print(exPoint)
    }
    
    private func addAnnotation(_ sender: CLLocationCoordinate2D) {
        
        let placePoint = MKPointAnnotation()
        placePoint.title = "Marking place \(exPoint.count)"
        placePoint.coordinate = sender
        mapView.addAnnotation(placePoint)
    }
    
    // MARK: - Action Method
    @objc private func textFieldShouldReturn(_ sender: UITextField) {
        
        let geocoder = CLGeocoder()
        let location = textFiled.text!
        
        geocoder.geocodeAddressString(location, completionHandler: { (placeMark, error) in
            guard let placeMark = placeMark?.first else { return }
            
            if error != nil {
                return print(error!.localizedDescription)
            }
            
            let placePoint = placeMark.location?.coordinate
            
            self.setRegion(coordinate: placePoint!)
        })
        
        sender.resignFirstResponder()
    }
    
    @objc private func removeOverlays(_ sender: UIButton) {
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        exPoint = []
    }
    
    @objc private func dismissButtonEvent(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @objc private func checkButtonEvent(_ sender: UIButton) {
        guard let vc = presentingViewController as? CustomTapBarController else { return }
        if !textFiled.text!.isEmpty {
            vc.thirdTab.locationLabel.text = self.textFiled.text!
            
            presentingViewController?.dismiss(animated: true)
        } else {
            let alert = UIAlertController(title: "장소를 검색해주세요", message: nil, preferredStyle: .alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self.present(alert, animated: true)
        }
    }
}
