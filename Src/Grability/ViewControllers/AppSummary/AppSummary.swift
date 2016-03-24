//
//  AppSummary.swift
//  Grability
//
//  Created by Ahmad Abdul-Gawad Mahmoud on 3/22/16.
//  Copyright © 2016 Ahmad Abdul-Gawad Mahmoud. All rights reserved.
//

import UIKit

class AppSummary: BaseViewController {

    var selectedApp: Entry?
    
    // outlets
    
    @IBOutlet weak var labelAppName: UILabel!
    @IBOutlet weak var labelArtist: UILabel!
    @IBOutlet weak var imageViewAppImg: UIImageView!
    @IBOutlet weak var buttonPrice: UIButton!
    @IBOutlet weak var labelAppDescription: UILabel!
    @IBOutlet weak var labelSellerName: UILabel!
    @IBOutlet weak var labelCategoryName: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelRights: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // pre set-up
        
        preSettings()
    }
    
    func preSettings() {
        
        setupNavigationBar()
        
        // fill view with data
        
        fillView()
        
        imageViewAppImg.layer.cornerRadius = 20.0
        imageViewAppImg.layer.masksToBounds = true
        imageViewAppImg.layer.borderWidth = 0.1
        imageViewAppImg.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        buttonPrice.layer.cornerRadius = 7.0
        buttonPrice.layer.masksToBounds = true
        buttonPrice.layer.borderWidth = 0.3
        buttonPrice.layer.borderColor = UIColor.grayColor().CGColor
    }
    
    override func setupNavigationBar() {

        // set nav bar title.
        
        self.title = selectedApp?.title.label
        
    }
    
    func fillView() {
        
        // app name
        
        labelAppName.text = selectedApp?.title.label
        
        labelArtist.text = (selectedApp?.imartist.label)! + "  >"
        
         //fetch App image sized 100 * 100
        
        let imageApp = selectedApp!.imimage[2] as? ImImage
        let imageURL = NSURL(string: imageApp!.label)

        // set app image.
        imageViewAppImg.setImageWithURL(imageURL, placeholderImage: UIImage(named: "placeholder"), usingActivityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        
        //let price: String = selectedApp?.imprice.attributes.amount
        
        //let currency: String = selectedApp?.imprice.attributes.currency
        
        
        //buttonPrice.setTitle(currency + " " + price, forState: .Normal)
        
        labelAppDescription.text = selectedApp?.summary.label
        
        labelSellerName.text = selectedApp?.imartist.label
        
        labelCategoryName.text = selectedApp?.category.attributes.label
        
        labelReleaseDate.text = selectedApp?.imreleaseDate.attributes.label
        
        labelRights.text = selectedApp?.rights.label
        
        
    }



}
