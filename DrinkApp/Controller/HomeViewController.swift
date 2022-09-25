//
//  HomeViewController.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/9/22.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var drinksMenus = [DrinksMenu]()

    
    lazy var homeTableView : UITableView = {
        let table = UITableView()
        table.layer.bounds = view.bounds
        table.allowsSelection = false
        table.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchMenuData()
    }
    
    func updateUI() {
        
        print("HomeView")
        view.backgroundColor = .systemBackground
        title = "首頁"
        
        view.addSubview(homeTableView)
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        homeTableView.center = view.center
        homeTableView.rowHeight = 120
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinksMenus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        let index = drinksMenus[indexPath.row]
        cell.itemTitleLabel?.text = index.name
        return cell
        
    }
    
    func fetchMenuData(){
        APICaller.shared.getMenu{[weak self] result in
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let drinksmenu):
                    self?.drinksMenus = drinksmenu
                    DispatchQueue.main.async {
                        self?.homeTableView.reloadData()
                    }
                }
        }
    }

}
