//
//  AccauntViewController.swift
//  E-shop
//
//  Created by SOCD on 2/6/23.
//  Copyright © 2023 FINKI-191257. All rights reserved.
//

import UIKit

class AccauntViewController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var addres: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var lastName: UITextField!
    var fName: String?
    var pas: String?
    var add: String?
    var num: String?
    var usr: String?
    var lName: String?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func clickRegister(_ sender: Any) {
        fName = firstName.text
        pas = pass.text
        add = addres.text
        num = number.text
        usr = username.text
        lName = lastName.text
        UserDefaults.standard.set(fName, forKey: "fName")
        UserDefaults.standard.set(pas, forKey: "pas")
        UserDefaults.standard.set(add, forKey: "add")
        UserDefaults.standard.set(num, forKey: "num")
        UserDefaults.standard.set(usr, forKey: "usr")
        UserDefaults.standard.set(lName, forKey: "lName")
        dataPost()
        
        
    }
    
    func dataPost()
    {
        let url = URL(string: "http://localhost:8080/api/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let postData = [
        "username": usr,
        "password": pas,
        "firstName": fName,
        "lastName": lName,
        "phoneNumber": num,
        "adres": add]
        let encoder = JSONEncoder()
        request.httpBody = try! encoder.encode(postData)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                print("Error: Invalid server response")
                return
            }
            if let data = data {
                print("Success: \(data)")
            }
        }
        task.resume()
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
