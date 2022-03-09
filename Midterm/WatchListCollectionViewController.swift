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

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: Collection View Methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showStore.watchlist.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Show", for: indexPath) as? ShowCollectionViewCell else {
            fatalError("Unable to dequeue ShowCell")
        }
        
        let show = showStore.watchlist[indexPath.item]
        
        cell.episodeName?.text = show.trackName
        cell.showName?.text = show.collectionName
        
        if(show.contentAdvisoryRating == "TV-MA") {
            cell.contentRating?.image = UIImage(systemName: "eye.trianglebadge.exclamationmark")
        } else {
            cell.contentRating?.image = UIImage(systemName: "eye")
        }
        
        return cell
    }
    
    //MARK: Delete WatchList Item Method
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let show = showStore.watchlist[indexPath.item]
            
        let showAlert = UIAlertController(title: "Delete Episode?", message: "Do you want to remove \(show.trackName) from your watch list?", preferredStyle: .alert)
            
            showAlert.addAction(UIAlertAction(title: "Delete", style: .default) {
                [weak self] _ in
                self?.showStore.watchlist.remove(at: indexPath.item)
                self?.collectionView.reloadData()
            })
            
            showAlert.addAction(UIAlertAction(title: "Cancel", style: .default) {
                [weak self] _ in
                self?.dismiss(animated: true)
            })
            
            present(showAlert, animated: true)
        }

}
