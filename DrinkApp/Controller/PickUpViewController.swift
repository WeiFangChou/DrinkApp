//
//  DrinkViewController.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/9/22.
//

import UIKit



class PickUpViewController: UIViewController, HistoryViewControllerDelegate {


    
    lazy var pickerView : UIPickerView = {
        let picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    lazy var pickupTableView : UITableView = {
       
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height),style: .insetGrouped)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .MilkGreen
        table.register(UINib(nibName: "PickupTableViewCell", bundle: nil), forCellReuseIdentifier: PickupTableViewCell.Identifier)
        return table
    }()
    
    var order:Order?
    
    var shops : [Shop] = [
        Shop(shopName: "新莊中正店", shopAddress: "新莊區中正路1號", shopLatitude: 25.0322622, shopLongitude: 121.4329107,shopCity:"新北市",shopRegion:"新莊區", shopBusiness: [Business(Monday: Hours(StartTime: 8, EndTime: 9), Tuesday: Hours(StartTime: 8, EndTime: 9), Wednesday: Hours(StartTime: 8, EndTime: 9), Thursday: Hours(StartTime: 8, EndTime: 9), Friday: Hours(StartTime: 8, EndTime: 9), Saturday: Hours(StartTime: 8, EndTime: 9), Sunday: Hours(StartTime: 8, EndTime: 9))]),
        Shop(shopName: "板橋中正店", shopAddress: "板橋區中正路1號", shopLatitude: 25.0166494, shopLongitude: 121.4760084,shopCity:"新北市",shopRegion:"板橋區", shopBusiness: [Business(Monday: Hours(StartTime: 8, EndTime: 9), Tuesday: Hours(StartTime: 8, EndTime: 9), Wednesday: Hours(StartTime: 8, EndTime: 9), Thursday: Hours(StartTime: 8, EndTime: 9), Friday: Hours(StartTime: 8, EndTime: 9), Saturday: Hours(StartTime: 8, EndTime: 9), Sunday: Hours(StartTime: 8, EndTime: 9))]),
        Shop(shopName: "北車中正店", shopAddress: "台北市中正路1號", shopLatitude: 25.0322622, shopLongitude: 121.4329107,shopCity:"台北市",shopRegion:"中正區", shopBusiness: [Business(Monday: Hours(StartTime: 8, EndTime: 9), Tuesday: Hours(StartTime: 8, EndTime: 9), Wednesday: Hours(StartTime: 8, EndTime: 9), Thursday: Hours(StartTime: 8, EndTime: 9), Friday: Hours(StartTime: 8, EndTime: 9), Saturday: Hours(StartTime: 8, EndTime: 9), Sunday: Hours(StartTime: 8, EndTime: 9))]),
        Shop(shopName: "基隆中山店", shopAddress: "基隆區中山區中正路一段1號", shopLatitude: 25.0166494, shopLongitude: 121.4760084,shopCity:"基隆市",shopRegion:"中山區", shopBusiness: [Business(Monday: Hours(StartTime: 8, EndTime: 9), Tuesday: Hours(StartTime: 8, EndTime: 9), Wednesday: Hours(StartTime: 8, EndTime: 9), Thursday: Hours(StartTime: 8, EndTime: 9), Friday: Hours(StartTime: 8, EndTime: 9), Saturday: Hours(StartTime: 8, EndTime: 9), Sunday: Hours(StartTime: 8, EndTime: 9))])]
    
    var citys:[City] = [City(cityName: "台北市",
                             region: [Region(regionName: "中正區", regionNumber: 100),
                                      Region(regionName: "中山區", regionNumber: 101),
                                      Region(regionName: "信義區", regionNumber: 102)]),
                        City(cityName: "新北市",
                             region: [Region(regionName: "新莊區", regionNumber: 242),
                                      Region(regionName: "板橋區", regionNumber: 243),
                                      Region(regionName: "三重區", regionNumber: 244)]),
                        City(cityName: "基隆市",
                             region: [Region(regionName: "信義區", regionNumber: 200),
                                      Region(regionName: "仁愛區", regionNumber: 201),
                                      Region(regionName: "中山區", regionNumber: 202)]),
                        City(cityName: "桃園市",
                             region: [Region(regionName: "中壢區", regionNumber: 320)])]
    var currentShops:[Shop] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        
    }
    
    @objc func orderButtonTap() {
        
    }
    
    func setupUI() {
        view.addSubview(pickerView)
        view.addSubview(pickupTableView)
        pickupTableView.frame = CGRect(x: 0, y: 0 + 300, width: view.bounds.width, height: view.bounds.height - 300)
        pickerView.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 150)
        currentShops = shops
        
    }
    
    func preOrder(order: Order) {
        APICaller.shared.createOrder(order: order) { result in
            switch result{
            case .failure(let error):
                self.showAlertView(title: "Error", message: error.localizedDescription) { alertError in
                    print(alertError)
                }
                break
            case .success(let order):
                DispatchQueue.main.async {
                    let orderViewController = OrderViewController(order: order)
                    self.present(orderViewController, animated: true)
                }
                break
            }
        }
        
    }
    
    

}
extension PickUpViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentShops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PickupTableViewCell.Identifier, for: indexPath) as? PickupTableViewCell else {
            return UITableViewCell()
        }
        let index = currentShops[indexPath.row]
        cell.cityNameLabel.text = index.shopName
        cell.regionNameLabel.text = index.shopAddress
        cell.backgroundColor = .clear
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: nil, message: "開始訂購", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "確定", style: .default) { alert in
//            確定要訂購
            let usersDefault = UserDefaults.standard
            
            guard let orderUUIDString = usersDefault.string(forKey: "deviceUUID") else{ return }
            guard let orderUUID = UUID(uuidString: orderUUIDString ) else { return }
            let index = self.currentShops[indexPath.row]
            let nowDate = Date()
            let dateFormatter = DateFormatter()
            let dateString = dateFormatter.string(from: nowDate)
            let order = Order(shopName: index.shopName, shopAddress: index.shopAddress, orderUUID: orderUUID, createdate: dateString)
            self.preOrder(order: order)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel){ cancelAction in
//            取消訂購
            print("Cancel")
            return
        }
        alertController.addAction(alertAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
    
    
}


extension PickUpViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component{
            case 0:
                return citys[row].cityName
            case 1:
                let cityRow = pickerView.selectedRow(inComponent: 0)
                return citys[cityRow].region[row].regionName
            default:
                return ""
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        case 0:
            return citys.count
        case 1:
            let cityRow = pickerView.selectedRow(inComponent: 0)
            return citys[cityRow].region.count
        default:
            return 0
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: true)
        }
        let cityIndex = pickerView.selectedRow(inComponent: 0)
        let regionIndex = pickerView.selectedRow(inComponent: 1)
        let selectCity = citys[cityIndex].cityName
        let selectRegion = citys[cityIndex].region[regionIndex].regionName
        currentShops.removeAll()
        for shop in shops where shop.shopCity == selectCity && shop.shopRegion == selectRegion {
            currentShops.append(shop)
        }
        self.pickupTableView.reloadData()
    }
    
    
}
