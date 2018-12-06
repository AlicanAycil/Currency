//
//  CurrencyViewController.swift
//  Currency
//
//  Created by Alican Aycil on 28.11.2018.
//  Copyright © 2018 Alican Aycil. All rights reserved.
//

import Foundation
import UIKit
import PullToRefresh

class CurrencyViewController: BaseViewController {
    
    var didSetupConstraints = false
    lazy var tableView = UITableView()
    let refresher = PullToRefresh()
    
    let dataSource = DynamicValue<CurrencyModel>(CurrencyModel())
    
    lazy var viewModel : CurrencyViewModel = {
        let viewModel = CurrencyViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startLoader()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CurrencyViewCell.classForCoder(), forCellReuseIdentifier: "CurrencyViewCell")
        tableView.separatorStyle = .none
        tableView.addPullToRefresh(refresher, action: {
            self.viewModel.fetchCurrencies { [weak self] in
                self?.tableView.endRefreshing(at: .top)
            }
        })
        self.view.addSubview(tableView)
        
        self.dataSource.addAndNotify(observer: self) { [weak self] in
            guard (self?.dataSource.value.Rates.count)! > 0 else { return }
            self?.title = "\(self?.dataSource.value.Date ?? "") (\(self?.dataSource.value.Base ?? ""))"
            self?.tableView.reloadData()
        }
        
        
        self.viewModel.fetchCurrencies { [weak self] in
            self?.stopLoader()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            tableView.snp.makeConstraints { (make) in
                make.top.bottom.left.right.equalToSuperview()
            }
            didSetupConstraints = true
        }

        super.updateViewConstraints()
    }
    
}

extension CurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.value.Rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyViewCell", for: indexPath) as! CurrencyViewCell
        cell.set(rate: self.dataSource.value.Rates[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
