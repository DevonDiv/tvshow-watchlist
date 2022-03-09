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
            if !showStore.watchlist.contains(show) {
                showStore.watchlist.append(show)
                
                let showAlert = UIAlertController(title: "🎉Hooray!🎉", message: "\(show.collectionName) has been added to your watch list!", preferredStyle: .alert)
                showAlert.addAction(UIAlertAction(title: "OK", style: .default) {
                    [weak self] _ in
                    self?.navigationController?.popViewController(animated: true)
                })
                
                present(showAlert, animated: true)
            } else {
                let showAlert = UIAlertController(title: "\(show.collectionName) is already in your watch list", message: nil, preferredStyle: .alert)
                
                showAlert.addAction(UIAlertAction(title: "OK", style: .default) {
                    [weak self] _ in
                    self?.navigationController?.popViewController(animated: true)
                })
                
                present(showAlert, animated: true)
            }
        }
    }
    

    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        if let show = show {
            showTitle.text = show.collectionName
            showArtist.text = show.artistName
            showDescription.text = show.longDescription
            
            let url = URL(string: show.trackViewUrl)
            let request = URLRequest(url: url!)
            trackView.load(request)
        }
    }
    
    func showAlert(withTitle title: String, withMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) {
            [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(alertAction)
        
        present(alert, animated: true)
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
