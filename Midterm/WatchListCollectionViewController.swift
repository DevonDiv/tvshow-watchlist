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
        
        return cell
    }
    
    //TODO: Add method to remove show from watch list

}
