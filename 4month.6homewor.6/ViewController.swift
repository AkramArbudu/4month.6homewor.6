//
//  ViewController.swift
//  4month.6homewor.6
//
//  Created by акрам on 18/1/23.
//

import UIKit
import SnapKit
class ViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(UITableViewCell.self, forCellReuseIdentifier: "table_cell")

        return view
    }()
    
    let networkManager = NetworkManager()
    
    var memeState: MemeState?
    
    var memes: [Meme]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        getData()
        
            
            
            
            
        
        // Do any additional setup after loading the view.
    }
    
    func getData() {
        networkManager.parse { memeState in
            DispatchQueue.main.async {
                if let memeState = memeState {
                    self.memes = memeState.data.memes
                } else {
                    print("nil while parse")
                }
                self.tableView.reloadData()
            }
            
            
        }
    }

    func setupSubviews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let memes = memes else {
            return 0
        }
        
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "table_cell", for: indexPath)
        guard let memes = memes else {
            fatalError()
        }
        cell.textLabel?.text = memes[indexPath.row].name
        return cell
    }
   
}
extension ViewController: UITableViewDelegate  {
    
}

