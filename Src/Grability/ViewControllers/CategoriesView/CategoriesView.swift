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
    
    // keep user category selection
    
    var selectedCategoryIndex: Int?
    
    
    //MARK:- VIEW ACTIONS
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // set up UI
        preSettings()
    }
    
    func preSettings() {
        
        // because the categories list collection view hide it.
        
        self.view.bringSubviewToFront(activityIndCategories)
        
        if SharedData.sharedObj.connectionState != "OffLineNotCached" {
        
            // start animating the indicator, then make connection to get all categories
            
            activityIndCategories.startAnimating()
            
            server!.requestTopFreeApplications(onDelegate: self)
        }
        else  {
            
            // offline and not cached.
            
            Utils.showAlertDialogInView(withTilte: "Warning ⚠️", andMessage: "You're not connected to internet. No cached data founded so you should check your internet connection!", andButtonTitle: "OK ☑️")
            
        }

    }
    
    
    // used to get the unique values from an array.
    
    func uniq<S: SequenceType, E: Hashable where E==S.Generator.Element>(source: S) -> [E] {
        var seen: [E:Bool] = [:]
        return source.filter { seen.updateValue(true, forKey: $0) == nil }
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
        
        selectedCategoryIndex = indexPath.item
        
        self.performSegueWithIdentifier("goToAppsList", sender: nil)
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
        
        // get unique values

        categoriesList = uniq(categoriesList)
        
        // update categories collection view with the returned categories data.
        
        collectionViewCategories.reloadData()
        
        // hide indicator.
        
        activityIndCategories.stopAnimating()
        
        // store the returned response in the singleton obj.
        
        SharedData.sharedObj.returnedFeed = feed

    }
    
    func failResponseTopFreeAppsApi(withMessage message: String?) {
        
        //notify user
        Utils.showAlertDialogInView(withTilte: "Info", andMessage: message, andButtonTitle: "OK")
        
        // hide indicator
        activityIndCategories.stopAnimating()
    }
    
    //MAEK:- SEGUE
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "goToAppsList" {
            
            if let destinationVC = segue.destinationViewController as? AppsListView {
                
                destinationVC.passedCategoryName = categoriesList[selectedCategoryIndex!]
            }
        }
    }
    
    // layout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            
            // to view the collectionview as a list,
            
            return CGSizeMake(collectionView.frame.width, 65)

        } else if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            
            // to view the collectionview as a grid.

            return CGSizeMake(140, 65)
            
        } else {
            
            // unspecified.
            
            return CGSizeZero
        }
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        
        // we don't want additional animations brought by performBatchUpdates:completion:
        
        self.collectionViewCategories.collectionViewLayout.invalidateLayout()
    }
    
}
