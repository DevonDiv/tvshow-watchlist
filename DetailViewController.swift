//
//  DetailViewController.swift
//  Midterm
//
//  Created by Devon Divinecz on 2022-03-08.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: Properties
    var show: Show?
    var showStore: ShowStore!
    
    //MARK: Outlets
    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var showArtist: UILabel!
    @IBOutlet weak var showDescription: UILabel!
    
    //MARK: Actions
    @IBAction func addToWatchList(_ sender: Any) {
    }
    

    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        if let show = show {
            showTitle.text = show.collectionName
            showArtist.text = show.artistName
            showDescription.text = show.description
        }
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
