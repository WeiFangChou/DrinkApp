//
//  HomeViewController.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/9/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    var menus : [Menu] = []
    var dicMenus = Dictionary<String, Array<Menu>>()
    var sections: [String] = []
    
    lazy var homeTableView : UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .insetGrouped)
        
        tableView.allowsSelection = false
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        tableView.backgroundColor = .MilkGreen
        tableView.layer.bounds = view.bounds
        tableView.rowHeight = 170
        return tableView
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
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    func setupUI() {
        
        print("HomeView")
        view.backgroundColor = .MilkGreen
        title = "菜單"
        view.addSubview(homeTableView)
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        homeTableView.center = view.center
//        homeTableView.backgroundView = tableViewBackgroundView
        homeTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        homeTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        homeTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        homeTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        fetchMenuData()
    }
    
    
    
    func fetchMenuData(){
        print("FetchData")
        APICaller.shared.getMenu{ result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let drinksmenu):
                self.menus = drinksmenu.sorted{$0.type < $1.type}
                self.dicMenus = Dictionary(grouping: self.menus, by: { $0.type })
                self.sections = self.dicMenus.keys.sorted()
                DispatchQueue.main.async {
                    self.homeTableView.reloadData()
                }
            }
        }
    }
    
}

extension HomeViewController :  UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dicMenus[sections[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        if let rows = self.dicMenus[sections[indexPath.section]] {
            
            let row = rows[indexPath.row]
            
            cell.itemTitleLabel?.text = row.name
            cell.itemSub2TitleLabel?.text = (row.midPrice == nil ? "" : "中杯 : " + String(row.midPrice!) + "  ") + "大杯 : " + String(row.largePrice)
            cell.coldImageView.image = row.cold ? UIImage(named: "cold") : UIImage()
            cell.hotImageView.image = row.hot ? UIImage(named: "hot") : UIImage()
            cell.caffeineImageView.image = row.caffeine ? UIImage(named: "caffeine") : UIImage()
            cell.recommendImageView.image = row.recommend ? UIImage(named: "recommend") : UIImage()
            cell.newImageView.image = row.new ? UIImage(named: "new") : UIImage()
            cell.itemImageView.load(from: row.imageurl)
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.font = UIFont(name: "Arial-BoldMT", size: 25)
            headerView.textLabel?.textColor = .white
        }
    }
}
