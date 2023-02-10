//
//  Extension.swift
//  E-shop
//
//  Created by SOCD on 2/7/23.
//  Copyright © 2023 FINKI-191257. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    func load(urlString : String){
        guard let url = URL(string: urlString) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if  let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image=image
                    }
                }
                
            }
        }
    }
}
