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
        
        table.allowsSelection = false
        table.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        table.backgroundColor = .clear
        table.layer.bounds = view.bounds
        return table
    }()
    
    lazy var tableViewBackgroundView : UIView = {
       let view = UIView()
        let image = UIImage(named: "backgroundimg")
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)
        return view
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
        view.backgroundColor = .MilkGreen
        title = "首頁"
        
        
        view.addSubview(homeTableView)
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        homeTableView.center = view.center
        homeTableView.rowHeight = 120
        homeTableView.backgroundView = tableViewBackgroundView
        homeTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        homeTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        homeTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        homeTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinksMenus.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        let index = drinksMenus[indexPath.row]
        cell.itemTitleLabel?.text = index.name
        cell.itemSubTitleLabel?.text = index.midPrice == nil ? "" : "中杯：" + String(index.midPrice!)
        cell.itemSub2TitleLabel?.text = "大杯" + String(index.largePrice)
        if let url = index.imageurl{
            
            cell.itemImageView.fetchImagefromURL(fromURL: url)
        }
        cell.backgroundColor = .clear
        return cell
        
    }
    
    func fetchMenuData(){
        print("FetchData")
        APICaller.shared.getMenu{[weak self] result in
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let drinksmenu):
                self?.drinksMenus = drinksmenu.sorted{$0.type > $1.type}
                    DispatchQueue.main.async {
                        self?.homeTableView.reloadData()
                    }
                }
        }
    }

}
