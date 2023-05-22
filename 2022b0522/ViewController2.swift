//
//  ViewController2.swift
//  2022b0522
//
//  Created by hokyun Kim on 2023/05/22.
//

import UIKit

class ViewController2: UIViewController {

    var id : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(id)
        // Do any additional setup after loading the view.
    }


    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
