//
//  ShopViewController.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/9/22.
//

import UIKit
import ActivityKit
import CoreLocation
import MapKit

class ShopViewController: UIViewController {
    
    var shops :[Shop] = [
        Shop(shopName: "新莊中正店", shopAddress: "新莊區中正路1號", shopLatitude: 25.0322622, shopLongitude: 121.4329107,shopCity:"新北市",shopCountry:"新莊區", shopBusiness: [Business(Monday: Hours(StartTime: 8, EndTime: 9), Tuesday: Hours(StartTime: 8, EndTime: 9), Wednesday: Hours(StartTime: 8, EndTime: 9), Thursday: Hours(StartTime: 8, EndTime: 9), Friday: Hours(StartTime: 8, EndTime: 9), Saturday: Hours(StartTime: 8, EndTime: 9), Sunday: Hours(StartTime: 8, EndTime: 9))]),
        Shop(shopName: "板橋中正店", shopAddress: "板橋區中正路1號", shopLatitude: 25.0166494, shopLongitude: 121.4760084,shopCity:"新北市",shopCountry:"板橋區", shopBusiness: [Business(Monday: Hours(StartTime: 8, EndTime: 9), Tuesday: Hours(StartTime: 8, EndTime: 9), Wednesday: Hours(StartTime: 8, EndTime: 9), Thursday: Hours(StartTime: 8, EndTime: 9), Friday: Hours(StartTime: 8, EndTime: 9), Saturday: Hours(StartTime: 8, EndTime: 9), Sunday: Hours(StartTime: 8, EndTime: 9))]),
        Shop(shopName: "北車中正店", shopAddress: "台北市中正路1號", shopLatitude: 25.0322622, shopLongitude: 121.4329107,shopCity:"台北市",shopCountry:"中正區", shopBusiness: [Business(Monday: Hours(StartTime: 8, EndTime: 9), Tuesday: Hours(StartTime: 8, EndTime: 9), Wednesday: Hours(StartTime: 8, EndTime: 9), Thursday: Hours(StartTime: 8, EndTime: 9), Friday: Hours(StartTime: 8, EndTime: 9), Saturday: Hours(StartTime: 8, EndTime: 9), Sunday: Hours(StartTime: 8, EndTime: 9))]),
        Shop(shopName: "基隆中正店", shopAddress: "基隆區中正路1號", shopLatitude: 25.0166494, shopLongitude: 121.4760084,shopCity:"基隆市",shopCountry:"中正區", shopBusiness: [Business(Monday: Hours(StartTime: 8, EndTime: 9), Tuesday: Hours(StartTime: 8, EndTime: 9), Wednesday: Hours(StartTime: 8, EndTime: 9), Thursday: Hours(StartTime: 8, EndTime: 9), Friday: Hours(StartTime: 8, EndTime: 9), Saturday: Hours(StartTime: 8, EndTime: 9), Sunday: Hours(StartTime: 8, EndTime: 9))])]
    
    var country:[String] = ["新北市","台北市","桃園市","基隆市"]
    
    lazy var shopTableView : UITableView = {
        let tableView = UITableView()
        tableView.bounds = view.bounds
        tableView.register(UINib(nibName: "ShopTableViewCell", bundle: nil), forCellReuseIdentifier: "ShopTableViewCell")
        
        return tableView
    }()

    
    lazy var shopCollectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 30, height: 30)
        flowLayout.estimatedItemSize = CGSize(width: 30, height: 30)
        flowLayout.minimumLineSpacing = 5.0
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 40), collectionViewLayout: flowLayout)
        
        collectionView.register(UINib(nibName: "ShopCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ShopCollectionViewCell")
        
        
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }
    
    
    func updateUI() {
        
        view.addSubview(shopTableView)
        shopTableView.tableHeaderView = shopCollectionView
        
        shopTableView.center = view.center
        shopTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        shopTableView.leftAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        shopTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        shopTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        shopTableView.delegate = self
        shopTableView.dataSource = self
        shopCollectionView.delegate = self
        shopCollectionView.dataSource = self
    }
    
    func whereCountry(city: String) -> [Shop] {
        var shops: [Shop] = []
        for index in 0..<self.shops.count where self.shops[index].shopCity == city {
            shops.append(self.shops[index])
        }
        return shops
    }


}

extension ShopViewController: UITableViewDelegate, UITableViewDataSource,MKMapViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShopTableViewCell", for: indexPath) as! ShopTableViewCell? else {
            print("cell not found")
            return UITableViewCell()
        }
        
        let index = shops[indexPath.row]
        let locationCoordinate = CLLocationCoordinate2D(latitude: index.shopLatitude, longitude: index.shopLongitude)
        cell.shopLabel.text = index.shopName
        cell.addressLabel.text = index.shopAddress
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = locationCoordinate
        pointAnnotation.title = index.shopName
        pointAnnotation.subtitle = index.shopCountry
        
        let local = MKCoordinateRegion(center: locationCoordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        cell.shopMapView.setRegion(local, animated: true)
        cell.shopMapView.addAnnotation(pointAnnotation)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}

extension ShopViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return country.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCollectionViewCell", for: indexPath) as! ShopCollectionViewCell? else {
            
            return UICollectionViewCell()
        }
        let index = country[indexPath.row]
        cell.regionLabel.text = index
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(whereCountry(city: country[indexPath.row]))
    }
    
    
    
    
}
