//
//  AppSummary.swift
//  Grability
//
//  Created by Ahmad Abdul-Gawad Mahmoud on 3/22/16.
//  Copyright © 2016 Ahmad Abdul-Gawad Mahmoud. All rights reserved.
//

import UIKit

class AppSummary: BaseViewController {

    var selectedAppIndex: Int!

    var currentAppEntry: Entry?
    
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
        
        // get the Feed object that stored in the singleton obj.
        
        currentAppEntry = SharedData.sharedObj.returnedFeed?.entry[selectedAppIndex] as? Entry
        
        // assign the Entry list contained in the stored returnedFeed obj. to entryList array.
        
        setupNavigationBar()
        
        // fill view with data
        
        fillView()
        
        imageViewAppImg.layer.cornerRadius = 20.0
        imageViewAppImg.layer.masksToBounds = true
        imageViewAppImg.layer.borderWidth = 0.1
        imageViewAppImg.layer.borderColor = UIColor.lightGrayColor().CGColor
    }
    
    func setupNavigationBar() {
        
        // set up nav bar.
        
        let attributes = [
            NSForegroundColorAttributeName: UIColor.darkGrayColor(),
            NSFontAttributeName: UIFont.systemFontOfSize(15, weight: 1)
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.tintColor = UIColor.darkGrayColor()
        
        // set nav bar title.
        
        self.title = currentAppEntry?.title.label
        
    }
    
    func fillView() {
        
        // app name
        
        labelAppName.text = currentAppEntry?.title.label
        
        labelArtist.text = currentAppEntry?.imartist.label
        
         //fetch App image sized 100 * 100
        
        let imageApp = currentAppEntry!.imimage[2] as? ImImage
        let imageURL = NSURL(string: imageApp!.label)

        // set app image.
        imageViewAppImg.setImageWithURL(imageURL, placeholderImage: UIImage(named: "placeholder"), usingActivityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        
        //let price: String = currentAppEntry?.imprice.attributes.amount
        
        //let currency: String = currentAppEntry?.imprice.attributes.currency
        
        
        //buttonPrice.setTitle(currency + " " + price, forState: .Normal)
        
        labelAppDescription.text = currentAppEntry?.summary.label
        
//        labelSellerName.text = currentAppEntry?.imartist.label
        
        labelCategoryName.text = currentAppEntry?.category.attributes.label
        
//        labelReleaseDate.text = currentAppEntry?.imreleaseDate.attributes.label
        
        labelRights.text = currentAppEntry?.rights.label
        
        
    }



}
