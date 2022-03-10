//
//  WatchListCollectionViewController.swift
//  Midterm
//
//  Created by Devon Divinecz on 2022-03-08.
//

import UIKit

class WatchListCollectionViewController: UICollectionViewController {
    
    //MARK: Properties
    var showStore: ShowStore!

    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //reload the collection view on tab bar navigation
        self.collectionView.reloadData()
    }
    
    
    //MARK: Collection View Methods
    
    //function  to delcare the amount of items in the section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showStore.watchlist.count
    }
    
    //function to populate thew collection view cells
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Show", for: indexPath) as? ShowCollectionViewCell else {
            //if you cannot access showCell from the method
            fatalError("Unable to dequeue ShowCell")
        }
        
        //show item in the watch list array from the index path
        let show = showStore.watchlist[indexPath.item]
        
        //set the labels accordingly
        cell.episodeName?.text = show.trackName
        cell.showName?.text = show.collectionName
        
        //check if the show if rated TV-MA
        if(show.contentAdvisoryRating == "TV-MA") {
            //if the show is rated TV-MA the UIImage will be an advisory warning
            cell.contentRating?.image = UIImage(systemName: "eye.trianglebadge.exclamationmark")
        } else {
            cell.contentRating?.image = UIImage(systemName: "eye")
        }
        
        return cell
    }
    
    //MARK: Delete WatchList Item Method
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //populate the show var with the selected show from the watch list
        let show = showStore.watchlist[indexPath.item]
            
        //alert message to ask the user if they want to delete the selected show
        let showAlert = UIAlertController(title: "Delete Episode?", message: "Do you want to remove \(show.trackName) from your watch list?", preferredStyle: .alert)
            
        //delete action to remove the current show from the watchlist array
        showAlert.addAction(UIAlertAction(title: "Delete", style: .default) {
            [weak self] _ in
            self?.showStore.watchlist.remove(at: indexPath.item)
            self?.collectionView.reloadData()
        })
        
        //action to close the alert message
        showAlert.addAction(UIAlertAction(title: "Cancel", style: .default) {
            [weak self] _ in
            self?.dismiss(animated: true)
        })
            
        present(showAlert, animated: true)
    }

}
