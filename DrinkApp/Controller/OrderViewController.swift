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
                    shoppingBagButton.setTitle("檢視購物車 (\(count))", for: .normal)
                    shoppingBagButton.isHidden = false
                }
            }
        }
    }
    var menus : [Menu] = []
    var dicMenus = Dictionary<String, Array<Menu>>()
    var sections: [String] = []
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        view.axis = .vertical
        view.center = self.view.center
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 0
        view.addArrangedSubview(orderInfoView)
        view.addArrangedSubview(orderTableView)
        view.addArrangedSubview(shoppingBagButton)
        return view
    }()
    
    lazy var orderInfoView : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.addSubview(orderInfoLabel)
        
        return view
    }()
    
    lazy var orderInfoLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 5, width: 100, height: 20))
        label.contentMode = .center
        label.text = ""
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    
    lazy var orderTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height ), style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: OrderTableViewCell.Identifier)
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    lazy var shoppingBagButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 70))
        button.setTitle("檢視購物車", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(shoppingBagButtonTapped), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        button.isHidden = true
        button.heightAnchor.constraint(equalToConstant: 65).isActive = true
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
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
        view.addSubview(stackView)
        self.isModalInPresentation = true
        presentationController?.delegate = self
        shoppingBagButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35).isActive = true
        shoppingBagButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: nil)
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
                self.dicMenus = Dictionary(grouping: self.menus, by: { $0.type })
                self.sections = self.dicMenus.keys.sorted()
                DispatchQueue.main.async {
                    self.orderTableView.reloadData()
                }
            }
        }
        
    }
    
    @objc func shoppingBagButtonTapped() {
        if let order = order {
            print(order)
            let shopbagViewController = ShopBagViewController(order: order)
            shopbagViewController.delegate = self
            APICaller.shared.updateOrder(order: order) { [weak self] result in
                guard let self = self else {return}
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let success):
                    print(success)
                    DispatchQueue.main.async {
                        self.present(shopbagViewController, animated: true)
                    }
                }
            }
        }
    }
    
    
}

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dicMenus[sections[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.Identifier, for: indexPath) as? OrderTableViewCell else {
            return UITableViewCell()
        }
        if let rows = self.dicMenus[sections[indexPath.section]] {
            let row = rows[indexPath.row]
            cell.selectImageView.load(from: row.imageurl)
            cell.selectLabel.text = row.name
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? OrderTableViewCell else {
            return
        }
        if let row = self.dicMenus[sections[indexPath.section]]?[indexPath.row] {
            let drink = Drinks(id: row.id, name: row.name, cost: row.largePrice)
            let drinkInfoViewController = DrinkInfoViewController(drink: drink)
            drinkInfoViewController.delegate = self
            drinkInfoViewController.title = row.name
            present(drinkInfoViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.font = .systemFont(ofSize: 25)
            headerView.textLabel?.textColor = .white
        }
    }
}


extension OrderViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        let alertController = UIAlertController(title: nil, message: "Cancel ?", preferredStyle: .actionSheet)
        let alertAction = UIAlertAction(title: "Discard Changes", style: .default) { alert in
            self.showAlertView(title: "Error", message: "Failed to cancel order") {
                
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(alertAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
}

extension OrderViewController: DrinkInfoViewControllerDelegate {
    func drinkInfoChanged(drink: Drinks) {
        
        self.order?.addDrink(drink: drink)
        if let order = self.order {
            APICaller.shared.updateOrder(order: order) { [weak self] result  in
                switch result {
                case .failure(let error):
                    print("Error : ",error)
                case .success(let success):
                    print("Success : ",success)
                }
            }
        }
    }
    
    
}

extension OrderViewController: ShopBagViewControllerDelegate {
    func doneShoppingOrder(order: Order) {
        DispatchQueue.main.async {
            self.dismiss(animated: true) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let userInfo : [String: Order] = ["order": order]
                    let showOrderDetailName = Notification.Name(rawValue: "showOrderDetail")
                    NotificationCenter.default.post(name: showOrderDetailName, object: nil, userInfo: userInfo)
                }
            }
        }
    }
}
