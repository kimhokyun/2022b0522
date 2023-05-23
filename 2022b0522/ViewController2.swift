//
//  ViewController2.swift
//  2022b0522
//
//  Created by hokyun Kim on 2023/05/22.
//

import UIKit

class ViewController2: UIViewController {

    var id : String?
    var responseData:Data2 = Data2(conversation: Conversation(keyword: "", response: ""))
    var conversations: [Conversation] = []
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    func fetchData(keyword : String) {
        guard let url = URL(string: "http://localhost:3300/dcx/3/conversation/\(keyword)") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)

                return
            }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let Data2 = try decoder.decode(Data2.self, from: data)
                self.responseData = Data2
                self.conversations.append(self.responseData.conversation)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    print(self.responseData)
                }
            } catch let error {
                print(error.localizedDescription)
                self.conversations.append(Conversation(keyword: keyword, response: ""))
//                self.tableView.reloadData()
            }
        }.resume()
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func send(_ sender: Any) {
        fetchData(keyword: self.textField.text ?? "")
    }
    
}

extension ViewController2 : UITableViewDelegate, UITableViewDataSource {
    
    //cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.conversations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if conversations[indexPath.row].response.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell2", for: indexPath) as! CustomTableViewCell2
            cell.keywordLabel.text = conversations[indexPath.row].keyword
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell3", for: indexPath) as! CustomTableViewCell3
            cell.responseLabel.text = conversations[indexPath.row].response
            return cell
        }
        
    }

}
