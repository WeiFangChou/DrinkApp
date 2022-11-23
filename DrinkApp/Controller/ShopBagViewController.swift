//
//  ShopBagViewController.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/10/29.
//

import UIKit

protocol ShopBagViewControllerDelegate {
    func doneShoppingOrder(order: Order)
}

class ShopBagViewController: UIViewController {

    var order: Order?
    var delegate: ShopBagViewControllerDelegate?
    
    lazy var shoppingListTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), style: .insetGrouped)
        tableView.register(UINib(nibName: ShopBagTableViewCell.Identifier, bundle: nil), forCellReuseIdentifier: ShopBagTableViewCell.Identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        return tableView
    }()
    
    lazy var sendOrderButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        button.setTitle("點餐", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .MilkGreen
        button.addTarget(self, action: #selector(sendOrderButtonTap), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        view.addSubview(sendOrderButton)
        sendOrderButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        sendOrderButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        sendOrderButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        sendOrderButton.widthAnchor.constraint(equalToConstant: view.frame.width - 100).isActive = true
        sendOrderButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    @objc func sendOrderButtonTap() {
        if let order = order {
            self.dismiss(animated: true) {
                self.delegate?.doneShoppingOrder(order: order)
            }
        }
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
            if let drinkSize = row.size, let drinkIce = row.ice, let drinkSweet = row.sweet{
                detail += Size(rawValue: drinkSize)!.rawValue
                detail += " "
                detail += Ice(rawValue: drinkIce)!.value
                detail += " "
                detail += Sugar(rawValue: drinkSweet)!.value
            }
            
            if let addons = row.addons {
                detail += "\n"
                addons.forEach { addon in
                    detail += "\(addon), "
                }
            }
            cell.drinkNameLabel.text = row.name
            cell.drinkImageView.fetchImagefromURL(key: row.id.uuidString, fromURL: nil)
            cell.drinkDetailLabel.numberOfLines = 0
            cell.drinkDetailLabel.text = detail
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}
