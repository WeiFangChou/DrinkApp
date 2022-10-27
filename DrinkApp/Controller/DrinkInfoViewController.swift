//
//  DrinkInfoViewController.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/10/25.
//

import UIKit

protocol DrinkInfoViewControllerDelegate{
    func drinkInfoChanged()
}

class DrinkInfoViewController: UIViewController {
    var delegate: DrinkInfoViewControllerDelegate?
    var drink: Drinks
    
    lazy var drinkinfoTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        
        tableView.register(UINib(nibName: "DrinkInfoTableViewCell", bundle: nil), forCellReuseIdentifier: DrinkInfoTableViewCell.Identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    init(drink: Drinks){
        self.drink = drink
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        view.addSubview(drinkinfoTableView)
        drinkinfoTableView.center = view.center
        drinkinfoTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        drinkinfoTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        drinkinfoTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        drinkinfoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
    }
    
    @objc func saveDrinkInfo() {
        
    }
}


extension DrinkInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DrinkInfoTableViewCell.Identifier, for: indexPath) as! DrinkInfoTableViewCell
        cell.drinkInfoSelectImageView.image = UIImage(systemName: "moonphase.new.moon")
        cell.drinkInfoLabel.text = "TEST"
        
        return cell
    }
    
    
    
}
