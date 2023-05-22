//
//  ViewController.swift
//  2022b0522
//
//  Created by hokyun Kim on 2023/05/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var responseData : Data = Data(groupMember:[])
    var groups : [Group] = []
    var members : [Member] = []
    var sectionIsExpanded = [Bool]()  // array to keep track of section expansion status
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchData()

    }
    
    func fetchData() {
        guard let url = URL(string: "http://localhost:3300/dcx/3/groupMember") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let Data = try decoder.decode(Data.self, from: data)
                self.responseData = Data
                self.groups = self.responseData.groupMember
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.sectionIsExpanded = Array(repeating: true, count: self.groups.count )
                    print(self.responseData)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
   
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    //section
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.groups.count
    }
    
   
    // section 높이?
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        headerView.backgroundColor = .systemGray6
        
        let nameLabel = UILabel(frame: CGRect(x: 10, y: 10, width: tableView.frame.width - 40, height: 50))
        let arrowImageView = UIImageView(frame: CGRect(x: tableView.frame.width - 35, y: 25, width: 20, height: 20))
        
        let group = self.groups[section]
        nameLabel.text = group.group_name
        arrowImageView.image = sectionIsExpanded[section] ? UIImage(named: "close") : UIImage(named: "open")
        
        headerView.addSubview(nameLabel)
        headerView.addSubview(arrowImageView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        headerView.addGestureRecognizer(tapGesture)
        headerView.tag = section

        return headerView
    }
    
    @objc func handleTapGesture(_ sender: UITapGestureRecognizer) {
        guard let section = sender.view?.tag else {
            return
        }
        
        self.sectionIsExpanded[section] = !sectionIsExpanded[section]  // toggle section expansion status
        
        let arrowImageView = sender.view?.subviews.compactMap { $0 as? UIImageView }.first
        arrowImageView?.image = sectionIsExpanded[section] ? UIImage(named: "open") : UIImage(named: "close")  // update arrow direction
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
        self.tableView.reloadData()
    }
    
    
    //cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groups[section].member.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        let group = self.groups[indexPath.section]
        cell.nameLabel.text = group.member[indexPath.row].name
        cell.imageFileImageView.image = UIImage(named:group.member[indexPath.row].imageFile)

        return cell
    }
    // 각 셀의 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sectionIsExpanded[indexPath.section] ? 70 : 0 // section을 접으면 셀의 높이를 0으로 변경해서 row가 보이지 않도록 변경
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = self.groups[indexPath.section].member[indexPath.row].id
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        vc.id = id
        self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true)
    }

}

