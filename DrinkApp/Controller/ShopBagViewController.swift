//
//  ShopBagViewController.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/10/29.
//

import UIKit



class ShopBagViewController: UIViewController {

    var order: Order?
    
    
    lazy var shoppingListTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), style: .insetGrouped)
        tableView.register(UINib(nibName: ShopBagTableViewCell.Identifier, bundle: nil), forCellReuseIdentifier: ShopBagTableViewCell.Identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    init(order: Order) {
        self.order = order
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI () {
        
        view.addSubview(shoppingListTableView)
    }
}


extension ShopBagViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let order = order, let drinkCount = order.drinks {
            return drinkCount.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShopBagTableViewCell.Identifier, for: indexPath) as? ShopBagTableViewCell else {
            return UITableViewCell()
        }
        if let order = order, let drinks = order.drinks{
            let row = drinks[indexPath.row]
            var detail = ""
            cell.drinkNameLabel.text = row.name
            cell.drinkImageView.load(from: "https://www.milkshoptea.com/upload/product_catalog/2208261105400000001.png")
            cell.drinkDetailLabel.text = detail
            print(detail)
            
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}
