//
//  DrinkInfoViewController.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/10/25.
//

import UIKit

protocol DrinkInfoViewControllerDelegate{
    func drinkInfoChanged(drink: Drinks)
}

class DrinkInfoViewController: UIViewController {
    var delegate: DrinkInfoViewControllerDelegate?
    var drink: Drinks
    
    var sectionsData : [String: Array<String>] = ["尺寸":["中杯","大杯"],
                                                    "冰塊":["常溫","正常冰","少冰","去冰","微冰"],
                                                    "甜度":["無糖","正常","少糖","半糖","微糖"],
                                                    "其他":["加椰果","加珍珠","加布丁"]]
    var sections : [String] = ["尺寸","冰塊","甜度","其他"]
    
    lazy var headerView : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
        view.addSubview(cancelDrinkInfoButton)
        view.addSubview(saveDrinkInfoButton)
        return view
    }()
    
    lazy var saveDrinkInfoButton : UIButton = {
        let button = UIButton(frame: CGRect(x: view.bounds.width - 90, y: 15, width: 80, height: 25))
        button.setTitle("Add", for: .normal)
        
        button.addTarget(self, action: #selector(saveDrinkInfo), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelDrinkInfoButton: UIButton = {
       let button = UIButton(frame: CGRect(x:  25, y: 15, width: 80, height: 25))
        button.setTitle("Cancel", for: .normal)
        button.addTarget(self, action: #selector(cancelDrinkInfo), for: .touchUpInside)
        return button
    }()
    
    lazy var drinkinfoTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 50, width: view.bounds.width, height: view.bounds.height - 50))
        tableView.allowsMultipleSelection = true
        tableView.register(UINib(nibName: "DrinkInfoTableViewCell", bundle: nil), forCellReuseIdentifier: DrinkInfoTableViewCell.Identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    init(drink: Drinks){
        self.drink = drink
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        view.addSubview(headerView)
        view.addSubview(drinkinfoTableView)
        view.backgroundColor = .MilkGreen

    }
    
    @objc func saveDrinkInfo() {
        dismiss(animated: true) {
            self.delegate?.drinkInfoChanged(drink: self.drink)
        }
    }
    
    @objc func cancelDrinkInfo() {
        
        dismiss(animated: true)
    }
}


extension DrinkInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsData[sections[section]]!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DrinkInfoTableViewCell.Identifier, for: indexPath) as? DrinkInfoTableViewCell else {
            return UITableViewCell()
        }
        
        if let rows = sectionsData[sections[indexPath.section]] {
            let row = rows[indexPath.row]
            cell.drinkInfoSelectImageView.image = nil
            cell.drinkInfoLabel.text = row
            cell.drinkInfoSelectImageView.image = cell.isSelected ? UIImage(systemName: "moonphase.new.moon") : UIImage(systemName: "moonphase.new.moon.inverse")
        }
        
        if let indexSelectedRows = tableView.indexPathsForSelectedRows {
            for indexSelectedRow in indexSelectedRows {
                if let selectedCell = tableView.cellForRow(at: indexSelectedRow) as? DrinkInfoTableViewCell {
                    selectedCell.drinkInfoSelectImageView.image = UIImage(systemName: "moonphase.new.moon")
                }
            }
        }

       
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? DrinkInfoTableViewCell {
            cell.drinkInfoSelectImageView.image = UIImage(systemName: "moonphase.new.moon")
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        if let selectedIndexPathSection = tableView.indexPathsForSelectedRows?.first(where: { $0.section == indexPath.section}) {
            if let cell = tableView.cellForRow(at: selectedIndexPathSection) as? DrinkInfoTableViewCell{
                tableView.deselectRow(at: selectedIndexPathSection, animated: true)
                cell.drinkInfoSelectImageView.image = UIImage(systemName: "moonphase.new.moon.inverse")
            }
        }
        return indexPath
    }
}
