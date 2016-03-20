//
//  CategoriesView.swift
//  Grability
//
//  Created by Ahmad Abdul-Gawad Mahmoud on 3/20/16.
//  Copyright © 2016 Ahmad Abdul-Gawad Mahmoud. All rights reserved.
//

import UIKit

class CategoriesView: BaseViewController {

    
    //MARK:- UI CONTROLS
    
    // collection view that contains all categories for the applications.
    
    @IBOutlet var collectionViewCategories: UICollectionView!
    
    // activity indicator for categories collection view.
    
    @IBOutlet var activityIndCategories: UIActivityIndicatorView!
    
    // hold the names for the returned categories.
    
    var categoriesList = [String]()
    
    
    //MARK:- VIEW ACTIONS
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // set up UI
        preSettings()
    }
    
    func preSettings() {
        
        // start animating the indicator, then make connection to get all categories
        
        activityIndCategories.startAnimating()
        
        server!.requestTopFreeApplications(onDelegate: self)
    }
    

    //MARK:- collection view data source
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return categoriesList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionViewCategories.dequeueReusableCellWithReuseIdentifier("CategoryCell", forIndexPath: indexPath) as! CategoryCell
        
        // make each cell bounded and a rounded by a border.
        
        cell.labelCategoryName.layer.cornerRadius = 5.0
        cell.labelCategoryName.layer.masksToBounds = true
        cell.labelCategoryName.layer.borderWidth = 0.3
        cell.labelCategoryName.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        // category name
        
        cell.labelCategoryName.text = "  " + categoriesList[indexPath.item]
        
        return cell
    }
    
    
    //MARK:- collection view delegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        

    }

    //MARK:- TopFreeApplications Api handler methods.
    
    func successResponeTopFreeAppsApi(withFeed feed: Feed?) {
        
        // append the new returned recent books to arrayRecentBooks array,
        
        for entry in feed!.entry {
            
            let currentCategory = (entry as! Entry).category
            let categoryName = currentCategory.attributes.label
            
            // add this category name to categories list.
            
            categoriesList.append(categoryName)
        }
        
        // update categories collection view with the returned categories data.
        
        collectionViewCategories.reloadData()
        
        // hide indicator.
        
        activityIndCategories.stopAnimating()
    }
    
    func failResponseTopFreeAppsApi(withMessage message: String?) {
        
        //notify user
        Utils.showAlertDialogInView(self, withTilte: "Info", andMessage: message, andButtonTitle: "OK")
        
        // hide indicator
        activityIndCategories.stopAnimating()
    }
    
}
