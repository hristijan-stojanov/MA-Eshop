//
//  ProductDetailsViewController.swift
//  E-shop
//
//  Created by SOCD on 2/6/23.
//  Copyright © 2023 FINKI-191257. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productCategory: UILabel!
    @IBOutlet weak var productCena: UILabel!
    @IBOutlet weak var productRejting: UILabel!
    @IBOutlet weak var productDesk: UILabel!
    var data: Element?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productImage.load(urlString: data!.productImage)
        productName.text = data!.productName
        productCategory.text = data!.productCategory.categotyName
        productCena.text = "\(data!.productPrice) Den."
        productRejting.text = "\(data!.productRating)"
        productDesk.text = "\(data!.productDescription)"

        // Do any additional setup after loading the view.
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
