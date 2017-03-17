//
//  flickPhotosCollectionViewController.swift
//  flickSearch
//
//  Created by arora_72 on 17/03/17.
//  Copyright © 2017 indresh arora. All rights reserved.
//

import UIKit

final class flickPhotosCollectionViewController: UICollectionViewController {
    
    
    //mark: properties
    
    fileprivate let reuseIdentifier = "FlickCell"
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 50, left: 20, bottom: 50, right: 20)
    
     var searches = [FlickrSearchResults]() //searches is the array which keep tracks of all the searches made in the app
    
    let flickr = Flickr()  //refernce to the object that will do the searchinhg
    
    //let itemsPerRow: CGFloat = 3
    
    
   }
 extension flickPhotosCollectionViewController{
    
    func photoForIndexPath(indexPath: IndexPath) -> FlickrPhoto{
        
        
        
        return searches[indexPath.section].searchResults[indexPath.row]
    }
}


//holding textField delegate methods

extension flickPhotosCollectionViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //for adding spinning gear
        let activityMonitor = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        textField.addSubview(activityMonitor)
        activityMonitor.frame = textField.bounds
        activityMonitor.startAnimating()
        
        flickr.searchFlickrForTerm(textField.text!){
            results, Error in
            
            activityMonitor.removeFromSuperview()
            
            if let error = Error{
                print("Error searching \(error)")
                
                return
            }
            
            if let results = results{
                print("\(results.searchResults.count)  matching \(results.searchTerm)")
                self.searches.insert(results, at: 0)
                
                self.collectionView?.reloadData()
            }
        }
        textField.text = nil
        textField.resignFirstResponder()
        
        return true
        
    }
}

//mark : UIControllerViewDataSource

extension flickPhotosCollectionViewController{
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return searches.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return searches[section].searchResults.count
    }
    
    
//    override func collectionView(_ collectionView: UICollectionView,
//                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
//                                                      for: indexPath)
//        cell.backgroundColor = UIColor.black
//        // Configure the cell
//        return cell
//    }
//
//    }


    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! flickrPhotoCell
        
        let flickPhoto = photoForIndexPath(indexPath: indexPath)
        cell.backgroundColor = UIColor.white
        
        cell.imageView.image = flickPhoto.thumbnail
        
        return cell
        
        
        
}
//private extension flickPhotosCollectionViewController{
//    
//    func photoForIndexPath(_ indexPath: IndexPath) -> FlickrPhoto {
//        return searches[(indexPath as NSIndexPath).section].searchResults[(indexPath as NSIndexPath).row]
//    }
//
//
//}


}
