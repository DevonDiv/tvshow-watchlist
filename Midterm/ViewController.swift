//
//  ViewController.swift
//  Midterm
//
//  Created by Devon Divinecz on 2022-03-07.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    var showResults = [Show]()
    var showStore: ShowStore!
    
    //MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    

    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: Data Fetch Methods
    func createShowURL(from text: String) -> URL? {
        
        guard let cleanURL = text.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        else { fatalError("Can't make a url from :\(text)") }
        
        var urlString = "https://itunes.apple.com/search?term="
        urlString = urlString.appending(cleanURL)
        urlString = urlString.appending("&media=tvShow")
        
        return URL(string: urlString)
        
    }
    
    func fecthShows(from url: URL, for searchString: String) {
        
        let showTask = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if let dataError = error {
                print("Could not fetch tv shows: \(dataError.localizedDescription)")
            } else {
                
                do {
                    guard let someData = data else { return }
                    
                    let jsonDecoder = JSONDecoder()
                    let downloadedResults = try jsonDecoder.decode(Shows.self, from: someData)
                    self.showResults = downloadedResults.results
                    } catch let error {
                        print("Problem decoding: \(error.localizedDescription)")
                        }
            
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        showTask.resume()
    }
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndex = tableView.indexPathForSelectedRow else { return }

        let selectedShow = showResults[selectedIndex.row]
        let destinationVC = segue.destination as! DetailViewController
        
        destinationVC.show = selectedShow
        destinationVC.showStore = showStore

    }

}

