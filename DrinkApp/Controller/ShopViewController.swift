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
    
    var shops : [Shop] = [
        Shop(shopName: "新莊中正店", shopAddress: "新莊區中正路1號", shopLatitude: 25.0322622, shopLongitude: 121.4329107,shopCity:"新北市",shopRegion:"新莊區", shopBusiness: [Business(Monday: Hours(StartTime: 8, EndTime: 9), Tuesday: Hours(StartTime: 8, EndTime: 9), Wednesday: Hours(StartTime: 8, EndTime: 9), Thursday: Hours(StartTime: 8, EndTime: 9), Friday: Hours(StartTime: 8, EndTime: 9), Saturday: Hours(StartTime: 8, EndTime: 9), Sunday: Hours(StartTime: 8, EndTime: 9))]),
        Shop(shopName: "板橋中正店", shopAddress: "板橋區中正路1號", shopLatitude: 25.0166494, shopLongitude: 121.4760084,shopCity:"新北市",shopRegion:"板橋區", shopBusiness: [Business(Monday: Hours(StartTime: 8, EndTime: 9), Tuesday: Hours(StartTime: 8, EndTime: 9), Wednesday: Hours(StartTime: 8, EndTime: 9), Thursday: Hours(StartTime: 8, EndTime: 9), Friday: Hours(StartTime: 8, EndTime: 9), Saturday: Hours(StartTime: 8, EndTime: 9), Sunday: Hours(StartTime: 8, EndTime: 9))]),
        Shop(shopName: "北車中正店", shopAddress: "台北市中正路1號", shopLatitude: 25.0322622, shopLongitude: 121.4329107,shopCity:"台北市",shopRegion:"中正區", shopBusiness: [Business(Monday: Hours(StartTime: 8, EndTime: 9), Tuesday: Hours(StartTime: 8, EndTime: 9), Wednesday: Hours(StartTime: 8, EndTime: 9), Thursday: Hours(StartTime: 8, EndTime: 9), Friday: Hours(StartTime: 8, EndTime: 9), Saturday: Hours(StartTime: 8, EndTime: 9), Sunday: Hours(StartTime: 8, EndTime: 9))]),
        Shop(shopName: "基隆中山店", shopAddress: "基隆區中山區中正路一段1號", shopLatitude: 25.0166494, shopLongitude: 121.4760084,shopCity:"基隆市",shopRegion:"中山區", shopBusiness: [Business(Monday: Hours(StartTime: 8, EndTime: 9), Tuesday: Hours(StartTime: 8, EndTime: 9), Wednesday: Hours(StartTime: 8, EndTime: 9), Thursday: Hours(StartTime: 8, EndTime: 9), Friday: Hours(StartTime: 8, EndTime: 9), Saturday: Hours(StartTime: 8, EndTime: 9), Sunday: Hours(StartTime: 8, EndTime: 9))])]
    var currentShops : [Shop] = []
    var isFilter = false
    var country:[String] = ["新北市","台北市","桃園市","基隆市","台中市","新竹市"]
    var regionSelect = ""
    
    lazy var shopTableView : UITableView = {
        let tableView = UITableView()
        tableView.bounds = view.bounds
        tableView.register(UINib(nibName: "ShopTableViewCell", bundle: nil), forCellReuseIdentifier: "ShopTableViewCell")
        tableView.showsVerticalScrollIndicator = false
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
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
    }
    
    
    func setupUI() {
        
        view.addSubview(shopTableView)
        shopTableView.tableHeaderView = shopCollectionView
       
        shopTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        shopTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        shopTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        shopTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        shopTableView.center = view.center
        shopTableView.delegate = self
        shopTableView.dataSource = self
        shopCollectionView.delegate = self
        shopCollectionView.dataSource = self
        currentShops = shops
    }
}

extension ShopViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentShops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShopTableViewCell", for: indexPath) as! ShopTableViewCell? else {
            return UITableViewCell()
        }
        
        let index = currentShops[indexPath.row]
        let locationCoordinate = CLLocationCoordinate2D(latitude: index.shopLatitude, longitude: index.shopLongitude)
        cell.shopLabel.text = index.shopName
        cell.addressLabel.text = index.shopAddress
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = locationCoordinate
        pointAnnotation.title = index.shopName
        pointAnnotation.subtitle = index.shopRegion
        let local = MKCoordinateRegion(center: locationCoordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        cell.shopMapView.setRegion(local, animated: true)
        cell.shopMapView.addAnnotation(pointAnnotation)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = shops[indexPath.row]
        //comgooglemaps://?saddr=&daddr=25.0166494,121.4329107&directionsmode=driving
        let googlemapsUrl = "comgooglemaps://?saddr=&daddr=\(index.shopLatitude),\(index.shopLongitude)&directionsmode=driving"
        let applemapsUrl = "maps://?q=MilkShop,sll=\(index.shopLatitude),\(index.shopLongitude)"
        if (UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!)){
            if let googlemapsUrl = URL(string: googlemapsUrl){
                UIApplication.shared.openURL(googlemapsUrl)
            }
        }else if (UIApplication.shared.canOpenURL(URL(string: "map://")!)){
            if let applemapsUrl = URL(string: applemapsUrl){
                UIApplication.shared.openURL(applemapsUrl)
            }
        }
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
        
        cell.backgroundColor = cell.isSelected ? .red : .MilkGreen
        cell.regionLabel.text = index
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ShopCollectionViewCell
        let index = country[indexPath.row]
        if index == regionSelect{
            cell.isSelected = false
            cell.backgroundColor = .MilkGreen
            self.collectionView(collectionView, didDeselectItemAt: indexPath)
            regionSelect = ""
            return
        }
        cell.isSelected = true
        cell.backgroundColor = .red
        
        currentShops = shops.filter({ $0.shopCity.hasPrefix(index) })
        
        shopTableView.reloadData()
        regionSelect = index
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ShopCollectionViewCell
        cell.isSelected = false
        cell.backgroundColor = .MilkGreen
        currentShops = shops
        shopTableView.reloadData()
    }

    
}
