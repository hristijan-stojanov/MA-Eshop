//
//  HomeTableViewCell.swift
//  E-shop
//
//  Created by SOCD on 2/4/23.
//  Copyright © 2023 FINKI-191257. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    func getDarta()
    {
        var user = UserDefaults.standard.string(forKey: "usr")
        var str = "http://localhost:8080/api/addToShoppingCard/\(id!)/\(user!)"
        print(str)
        let url = URL(string: str)!
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

    }
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

    @IBOutlet weak var imagee: UIImageView!
    
    @IBOutlet weak var titel: UILabel!
    
    @IBOutlet weak var price: UILabel!
   
    @IBOutlet weak var card: UIButton!
    var id: Int?
    
    @IBAction func clickBoton(_ sender: Any) {
        print("pritisnato kopcee")
        print(id!)
        getDarta()
        sendNotification(inputString: "Uspesno dodavanje")
        
    }
    
}
