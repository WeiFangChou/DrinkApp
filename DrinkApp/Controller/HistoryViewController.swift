//
//  HistroyViewController.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/10/16.
//

import UIKit
protocol HistoryViewControllerDelegate{
    func preOrder(order: Order)
}

class HistoryViewController: UIViewController, HistoryTableViewCellDelegate{
    
    var delegate: HistoryViewControllerDelegate?
    
    lazy var refreshControl: UIRefreshControl = {
       let refreshControl = UIRefreshControl(frame: CGRect(x: view.center.x, y: view.center.y, width: 50, height: 50))
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)

        return refreshControl
    }()
    
    lazy var noDataView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "nodata"))
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        return imageView
    }()
    
    lazy var historyTableView : UITableView = {
        let tableview = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), style: .insetGrouped)
        tableview.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: HistoryTableViewCell.Identifier)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.allowsSelection = false
        tableview.backgroundView = noDataView
        tableview.addSubview(refreshControl)
        return tableview
    }()
    
    var orders : [Order] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI() {
        title = "最近訂單"
        view.addSubview(historyTableView)
        print("History")
        noDataView.isHidden = false
        historyTableView.backgroundColor = .MilkGreen
        historyTableView.center = view.center
        historyTableView.backgroundView = noDataView
        historyTableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heighConstant: 0)
        
        fetchHistoryOrder()
    }
    
    @objc func reloadData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.fetchHistoryOrder()
        }
    }
    
    func fetchHistoryOrder() {
        
        let userDefaults = UserDefaults.standard
        if let uuidString = userDefaults.string(forKey: "deviceUUID") {
            APICaller.shared.getOrders(orderUUID: uuidString) { reuslt in
                switch reuslt {
                case .success(let success):
                    DispatchQueue.main.async {
                        self.orders = success
                        self.historyTableView.reloadData()
                        self.noDataView.isHidden = true
                        self.refreshControl.endRefreshing()
                    }
                    
                case .failure(let failure):
                    DispatchQueue.main.async {
                        self.showAlertView(title: "Error", message: "Failed to fetch data"){
                            self.orders.removeAll()
                            self.noDataView.isHidden = false
                            self.refreshControl.endRefreshing()
                        }
                    }

                   
                }
            }
        }
    }
    
    func reOrderButtonTap(cell: HistoryTableViewCell) {
        guard let index = self.historyTableView.indexPath(for: cell)?.row else {
            return
        }
        tabBarController?.selectedIndex = 2
        delegate?.preOrder(order: orders[index])
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.Identifier, for: indexPath) as? HistoryTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        let index = orders[indexPath.row]
        var cost = 0
        if let drinks = index.drinks {
            for drink in drinks {
                if let addon = drink.addons?.count {
                    cost += drink.cost + (addon * 10)
                }
            }
        }
        cell.backgroundColor = .white
        cell.orderDrinksImage.image = UIImage(systemName: "wineglass")
        if let drinkID = index.drinks?[0].id{
            cell.orderDrinksImage.fetchImagefromURL(key: drinkID.uuidString, fromURL: nil)
        }
        cell.orderDrinksTitleLabel.text = index.shopName
        cell.orderDrinkssecTitleLabel.text = "\(index.drinks?.count ?? 0) 杯飲料・\(cost) 元"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "zh_Hant_TW")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Taipei")
        let newDate = dateFormatter.date(from: index.createdate)
        dateFormatter.dateFormat = "MM月dd日"
        let formattedDate = dateFormatter.string(from: newDate!)
        cell.orderDrinkstrdTitleLabel.text = "\(formattedDate)・已完成"
        return cell
    }
    
    
}
