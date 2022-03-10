//
//  DetailViewController.swift
//  Midterm
//
//  Created by Devon Divinecz on 2022-03-08.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    //MARK: Properties
    var show: Show?
    var showStore: ShowStore!
    
    //MARK: Outlets
    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var showArtist: UILabel!
    @IBOutlet weak var showDescription: UILabel!
    @IBOutlet weak var trackView: WKWebView!
    
    //MARK: Actions
    @IBAction func addToWatchList(_ sender: Any) {
        if let show = show {
            //check if the show being added is already in the watch list
            if !showStore.watchlist.contains(show) {
                //add the selected show to the watch list
                showStore.watchlist.append(show)
                
                //alert message to notify the user that the show was added to the watch list
                let showAlert = UIAlertController(title: "🎉Hooray!🎉", message: "\(show.collectionName) has been added to your watch list!", preferredStyle: .alert)
                //alert message action to close the alert
                showAlert.addAction(UIAlertAction(title: "OK", style: .default) {
                    [weak self] _ in
                    self?.navigationController?.popViewController(animated: true)
                })
                
                //present the alert message to the user
                present(showAlert, animated: true)
            } else {
                //alert message to notify the user that show already exists in the watch list
                let showAlert = UIAlertController(title: "\(show.collectionName) is already in your watch list", message: nil, preferredStyle: .alert)
                
                //alert message action to close the alert
                showAlert.addAction(UIAlertAction(title: "OK", style: .default) {
                    [weak self] _ in
                    self?.navigationController?.popViewController(animated: true)
                })
                
                //present the alert message to the user
                present(showAlert, animated: true)
            }
        }
    }
    

    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        //set the data of the detail view controller
        if let show = show {
            //add the appropriate text for the show
            showTitle.text = show.collectionName
            showArtist.text = show.artistName
            showDescription.text = show.longDescription
            
            //add the apple store url to the url var
            let url = URL(string: show.trackViewUrl)
            //create a url request using the url
            let request = URLRequest(url: url!)
            //load the url into the webview
            trackView.load(request)
        }
    }

}
