//
//  FirstViewController.swift
//  E-shop
//
//  Created by SOCD on 2/4/23.
//  Copyright © 2023 FINKI-191257. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate{
   
    
    @IBOutlet weak var table: UITableView!
    var apiData: [Element]?
    
    func getDarta()
    {
        let url = URL(string: "http://localhost:8080/api/product")!
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
        
        UNUserNotificationCenter.current()
        .getNotificationSettings { settings in
        switch settings.authorizationStatus {
        
        case .notDetermined:
        
        UNUserNotificationCenter.current()
        .requestAuthorization(options:
        [.alert, .badge, .sound]) { granted,
        error in
        if granted == true && error == nil {
          print("odobreno")
        }
        }
        case .denied:
        return
        case .authorized:
          print("authorized")
        case .provisional:
          print("provisional")
        @unknown default:
         return
          }
        }
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiData!.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeTableViewCell
        
        cell.id = apiData![indexPath.row].id
        cell.imagee.load(urlString: apiData![indexPath.row].productImage)
        cell.titel.text = apiData![indexPath.row].productName
        cell.price.text = "\( apiData![indexPath.row].productPrice) Den."
        
        return cell
       }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 150
       }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="show")
        {
            let vc = segue.destination as! ProductDetailsViewController
            let selectedIndex = table?.indexPathForSelectedRow?.row
            vc.data = apiData![selectedIndex ?? 1]
            
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    


}



