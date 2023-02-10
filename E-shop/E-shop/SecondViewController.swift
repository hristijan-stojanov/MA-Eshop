//
//  SecondViewController.swift
//  E-shop
//
//  Created by SOCD on 2/4/23.
//  Copyright © 2023 FINKI-191257. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    var cuma: Int = 0
    @IBOutlet weak var cena: UILabel!
    var apiData: [Element]?
    func sendNotification(inputString: String) ->Void
          {
              let content = UNMutableNotificationContent()
              content.title = inputString
              
              let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
              
              let notificationRequest =
              UNNotificationRequest.init(identifier:
              "Id", content: content,
              trigger: trigger)
              
              UNUserNotificationCenter.current()
              .add(notificationRequest) { error in
              print("Zakazano")}
              
          }
    func getDarta()
    {
        var user = UserDefaults.standard.string(forKey: "usr")
        let url = URL(string: "http://localhost:8080/api/shopingcard/\(user!)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print(error ?? "Unknown error")
                semaphore.signal()
                return
            }
        
            //let str = String.init(data: data ,encoding: .utf8)
            //print(str)
            let decoder = JSONDecoder()
            do{
                self.apiData = try decoder.decode([Element].self,from: data)
             
            
            
             
            } catch {
            print(error.localizedDescription)
            }
        
            semaphore.signal()
        }.resume()
        
        _ = semaphore.wait()

    }
    
    override func viewDidLoad() {
        getDarta()
        super.viewDidLoad()
        table?.dataSource=self
        table?.delegate=self
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiData!.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SoppingCartTableViewCell
        cuma += apiData![indexPath.row].productPrice
        cena.text = "\(cuma) DEN."
        cell.imageee.load(urlString: apiData![indexPath.row].productImage)
        cell.price.text = "\(apiData![indexPath.row].productPrice)"
        cell.title.text = apiData![indexPath.row].productName
        return cell
       }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 150
       }
    @IBAction func clickOrder(_ sender: Any) {
        var user = UserDefaults.standard.string(forKey: "usr")
             let url = URL(string: "http://localhost:8080/api/addOrder/\(user!)")!
             var request = URLRequest(url: url)
             request.httpMethod = "GET"
             
             let semaphore = DispatchSemaphore(value: 0)
             
             URLSession.shared.dataTask(with: request) { (data, response, error) in
                 guard let data = data else {
                     print(error ?? "Unknown error")
                     semaphore.signal()
                     return
                 }
             
                 //let str = String.init(data: data ,encoding: .utf8)
                 //print(str)

             
                 semaphore.signal()
             }.resume()
             
             _ = semaphore.wait()

         sendNotification(inputString: "Uspesno izvrsena naracka")
        
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="clickOrder")
        {
            let vc = segue.destination as! OrderViewController
            
          //  let selectedIndex = table?.indexPathForSelectedRow?.row
          //  vc.data = "food\(selectedIndex!)"
            
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }*/
    


}

