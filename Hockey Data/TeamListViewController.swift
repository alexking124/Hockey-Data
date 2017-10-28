//
//  TeamListViewController.swift
//  HockeyData
//
//  Created by Alex King on 10/28/17.
//  Copyright © 2017 Alex King. All rights reserved.
//

import TinyConstraints

class TeamListViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TeamListTableViewCell.self, forCellReuseIdentifier: String(describing: TeamListTableViewCell.self))
        return tableView
    }()
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
}

private extension TeamListViewController {
    
    func setupViews() {
        view.addSubview(tableView)
        tableView.edgesToSuperview()
    }
    
}

extension TeamListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 31
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: String(describing: TeamListTableViewCell.self), for: indexPath)
    }
    
}

extension TeamListViewController: UITableViewDelegate {
    
}
