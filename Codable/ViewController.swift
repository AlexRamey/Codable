//
//  ViewController.swift
//  Codable
//
//  Created by Alex Ramey on 1/6/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var donuts: [KrispyKremeDonut] = []
    let reuseIdentifier: String = "reuseIdentifier"
    
    // Swappable implementations
    // let donutFileIO: DonutFileIO = JsonFileIO()
    let donutFileIO: DonutFileIO = PlistFileIO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        self.donuts = donutFileIO.readDonuts()
        self.tableView.reloadData()
    }

    @IBAction func addDonut(){
        let rnd = Int(arc4random_uniform(10)) + 1
        
        let donut = KrispyKremeDonut(name: String(repeating: "🍩", count: rnd),
                                     price: 0.1 * Double(rnd),
                                     love: 10 * rnd)
        self.donuts.append(donut)
        self.tableView.reloadData()
        
        self.donutFileIO.writeDonuts(donuts: self.donuts)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.donuts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        cell?.textLabel?.text = self.donuts[indexPath.row].name
        return cell ?? UITableViewCell()
    }
}

