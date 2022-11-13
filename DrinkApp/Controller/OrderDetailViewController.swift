//
//  OrderInfoViewController.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/11/8.
//

import UIKit


class OrderDetailViewController: UIViewController {
    
    lazy var shopBagInfoTableView : UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), style: .insetGrouped)
        table.register(UINib(nibName: "OrderDetailTableViewCell", bundle: nil), forCellReuseIdentifier: OrderDetailTableViewCell.Identifier)
        table.backgroundColor = .MilkGreen
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    
    
    var order: Order?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .SkyBlue
        view.addSubview(shopBagInfoTableView)
        
        shopBagInfoTableView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heighConstant: 0)
        
        
    }
    
    init(order: Order) {
        self.order = order
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}

extension OrderDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let order = order, let drinks = order.drinks{
            return drinks.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderDetailTableViewCell.Identifier, for: indexPath) as? OrderDetailTableViewCell else  {
            return UITableViewCell()
        }
        if let drinks = order?.drinks{
            let row = drinks[indexPath.row]
            
        }
        return cell
    }
    
}
