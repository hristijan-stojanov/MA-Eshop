//
//  OrderViewController.swift
//  E-shop
//
//  Created by SOCD on 2/6/23.
//  Copyright © 2023 FINKI-191257. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
   @IBOutlet weak var table: UITableView!
    var apiData: [Element]?
    var orderList: [[Element]]?
      
      func getDarta()
      {
         var user = UserDefaults.standard.string(forKey: "usr")
          let url = URL(string: "http://localhost:8080/api/order/\(user!)")!
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
               
                self.orderList?.append(self.apiData!)
               // print(self.apiData)
              
               
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
        return  1
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OrderTableViewCell
        var lista: [String] = []
        for el in self.apiData!{
            lista.append("\(el.productName)    \(el.productPrice) dem.")
            print(el)
        }
        print(lista)
        cell.showOrder.text = lista.joined(separator: "\n")
        return cell
       }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
              return 180
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
