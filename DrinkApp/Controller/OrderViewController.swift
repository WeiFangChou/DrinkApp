//
//  OrderViewController.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/10/17.
//

import UIKit

class OrderViewController: UIViewController {
    
    var order : Order? {
        didSet{
            if let order = order, let count = order.drinks?.count{
                if count > 0 {
                    orderInfoLabel.text = "\(count)"
                    shoppingBagButton.setTitle("檢視購物車(\(count))", for: .normal)
                    shoppingBagButton.isHidden = false
                }
            }
        }
    }
    var menus : [Menu] = []
    
    lazy var orderInfoView : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 80))
        view.backgroundColor = .white
        view.addSubview(orderInfoLabel)
        return view
    }()
    
    lazy var orderInfoLabel : UILabel = {
       let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 40))
        
        label.text = ""
        label.textColor = .label
        return label
    }()
    
    lazy var orderTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: orderInfoView.bounds.minX, y: orderInfoView.bounds.maxY + 10,
                                                  width: view.bounds.width, height: view.bounds.height - 250), style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: OrderTableViewCell.Identifier)
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    lazy var shoppingBagButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 25, y: view.bounds.height - 150, width: view.bounds.width - 50, height: 50))
        button.setTitle("檢視購物車", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(shoppingBagButtonTapped), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        button.isHidden = true
        return button
    }()
    
    lazy var cancelButton: UIButton = {
       let button = UIButton(frame: CGRect(x: 50, y: 50, width: 40, height: 30))
        button.setTitle("Cancel", for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let order = order{
            APICaller.shared.deleteOrder(order: order) { result in
                switch result {
                case .failure(let error):
                    print("Error Delete : ",error)
                case .success(let success):
                    print("Success Delete : ",success)
                }
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    
    init(order: Order) {
        super.init(nibName: nil, bundle: nil)
        self.order = order
        self.title = order.shopName
        
    }
   required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       
   }
    

    
    
    func setupUI(){
        fetchMenu()
        view.backgroundColor = .MilkGreen
        view.addSubview(orderTableView)
        view.addSubview(shoppingBagButton)
        view.addSubview(orderInfoView)
        self.isModalInPresentation = true
        
        orderInfoView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        orderInfoView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        orderInfoView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        orderTableView.topAnchor.constraint(equalTo: orderInfoView.bottomAnchor).isActive = true
        orderTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        orderTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        orderTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        shoppingBagButton.topAnchor.constraint(equalTo: orderTableView.bottomAnchor).isActive = true
        shoppingBagButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        shoppingBagButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        shoppingBagButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        presentationController?.delegate = self
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            print("Timer")
            let drink = Drinks(id: UUID(), name: "TEST", size: "大杯", cost: 50, ice: 4, sweet: 4)
            self.order?.addDrink(drink: drink)
            print(self.order?.drinks?.count)
        }
    }
    
    @objc func cancelButtonTap(sender: UIButton) {
        print("cancel")
    }
    
    func fetchMenu() {
        
        APICaller.shared.getMenu { result in
            switch result {
            case .failure(let error):
                print(error)
                return
            case .success(let menus):
                self.menus = menus.sorted{$0.type < $1.type}
                DispatchQueue.main.async {
                    self.orderTableView.reloadData()
                }
            }
        }
        
    }
    
    @objc func shoppingBagButtonTapped() {
        
    }
    
    
        

}

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menus.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.Identifier, for: indexPath) as? OrderTableViewCell else {
            return UITableViewCell()
        }
        let index = menus[indexPath.row]
        
        cell.selectImageView.load(from: index.imageurl)
        cell.selectLabel.text = index.name
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? OrderTableViewCell else {
            return
        }
        let drinkInMenu = menus[indexPath.row]
        let drink = Drinks(id: drinkInMenu.id, name: drinkInMenu.name, size: "大杯", cost: drinkInMenu.largePrice, ice: 4, sweet: 4, addon: nil)
        let drinkInfoViewController = DrinkInfoViewController(drink: drink)
        drinkInfoViewController.delegate = self
        present(drinkInfoViewController, animated: true)
    }

    
    
    
    
}


extension OrderViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        let alertController = UIAlertController(title: nil, message: "Cancel ?", preferredStyle: .actionSheet)
        let alertAction = UIAlertAction(title: "Discard Changes", style: .default) { alert in
            self.dismiss(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(alertAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
}

extension OrderViewController: DrinkInfoViewControllerDelegate {
    func drinkInfoChanged() {
        
    }
    
    
}
