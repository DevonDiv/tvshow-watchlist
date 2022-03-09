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
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: Data Fetch Methods
    func createShowURL(from text: String) -> URL? {
        
        guard let cleanURL = text.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        else { fatalError("Can't make a url from :\(text)") }
        
        var urlString = "https://itunes.apple.com/search?term="
        urlString = urlString.appending(cleanURL)
        urlString = urlString.appending("&media=tvShow")
        
        print(urlString)
        
        return URL(string: urlString)
        
    }
    
    //MARK: Fetch Show
    func fetchShows(from url: URL, for searchString: String) {
        
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
                        print("Problem decoding: \(error)")
                        }
            
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        showTask.resume()
    }
    
    //MARK: Fetch Image
    
    func fetchImage(for path: String, in cell: ShowTableViewCell) {
        
        let imagePath = path
        
        guard let imageUrl = URL(string: imagePath) else {
            print("Can't find the url from \(imagePath)")
            return
        }
        
        let imageFetch = URLSession.shared.downloadTask(with: imageUrl) {
            url, response, error in
            
            if error == nil, let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {

                DispatchQueue.main.async {
                cell.showImageView.image = image
                }
            }
        }
        imageFetch.resume()
    }
    
    //MARK: Navigation Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndex = tableView.indexPathForSelectedRow else { return }

        let selectedShow = showResults[selectedIndex.row]
        let destinationVC = segue.destination as! DetailViewController
        
        destinationVC.show = selectedShow
        destinationVC.showStore = showStore

    }

}

//MARK: SearchBar Method
extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchQuery = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        
        if let showURL = createShowURL(from: searchQuery) {
            fetchShows(from: showURL, for: searchQuery)
        }
        
        searchBar.resignFirstResponder()
    }
    
}

//MARK: Table View Methods
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: Table View Data Method
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowCell", for: indexPath) as! ShowTableViewCell
        
        let show = showResults[indexPath.row]
        
        cell.collectionTitleLabel.text = show.collectionName
        cell.trackNameLabel.text = show.trackName
        cell.artistNameLabel.text = show.artistName
        cell.priceLabel.text = "$\(show.trackPrice)"
        
        if let showImage = show.artworkUrl100 {
            fetchImage(for: showImage, in: cell)
        }
        
        return cell
    }
    
}
