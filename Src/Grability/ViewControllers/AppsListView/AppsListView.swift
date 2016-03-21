//
//  AppsListView.swift
//  Grability
//
//  Created by Ahmad Abdul-Gawad Mahmoud on 3/21/16.
//  Copyright © 2016 Ahmad Abdul-Gawad Mahmoud. All rights reserved.
//

import UIKit

class AppsListView: BaseViewController {
    
    
    //MARK:- UI CONTROLS
    
    // collection view that contains returned apps.
    
    @IBOutlet var collectionViewAppsList: UICollectionView!
    
    // hold the Entry objects returned from Api response.
    
    var entryList = [Entry]()
    
    var passedCategoryName: String?
    
    
    //MARK:- VIEW ACTIONS
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // pre set-up
        
        preSettings()
    }
    
    func preSettings() {
        
        // get the Feed object that stored in the singleton obj.
        
        let returnedFeed = SharedData.sharedObj.returnedFeed
        
        // assign the Entry list contained in the stored returnedFeed obj. to entryList array.
        
        entryList = returnedFeed?.entry as! [Entry]
        
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        
        // set up nav bar.
        
        let attributes = [
            NSForegroundColorAttributeName: UIColor.darkGrayColor(),
            NSFontAttributeName: UIFont.systemFontOfSize(15, weight: 1)
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        // set nav bar title.
        
        self.navigationController?.navigationItem.title = passedCategoryName
        
    }
        
    
    
    
    //MARK:- collection view data source
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return entryList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionViewAppsList.dequeueReusableCellWithReuseIdentifier("AppCell", forIndexPath: indexPath) as! AppCell
        
        // make each app image bounded and rounded by a border.
        
        cell.imageViewAppImg.layer.cornerRadius = 5.0
        cell.labelCategoryName.layer.masksToBounds = true
        cell.labelCategoryName.layer.borderWidth = 0.1
        cell.labelCategoryName.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        // set app image, fetch app image url.
        // fetch the  current Entry object.
        
        let currentEntry = entryList[indexPath.item]
        
        // fetch App image sized 75 * 75
        
//        let imageAppStr = currentEntry.imimage[2] as! ImImage
//        let imageURL = NSURL(string: imageAppStr.label)
//        
//        // set app image.
//        
//        cell.imageViewAppImg.setImageWithURL(imageURL, placeholderImage: UIImage(named: "placeholder"), usingActivityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        
        // set App name.
        
        cell.labelAppName.text = currentEntry.title.label
        
        // set category name.
        
        cell.labelCategoryName.text = currentEntry.category.attributes.label
        
        return cell
    }
    
    
    //MARK:- collection view delegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
}
