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
        
        //remove any whitespace or characters that would cause an error
        guard let cleanURL = text.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        else { fatalError("Can't make a url from :\(text)") }
        
        //declare the beginning of the itunes api link
        var urlString = "https://itunes.apple.com/search?term="
        //append the search term to the end of the api link
        urlString = urlString.appending(cleanURL)
        //append the search filter to the end of the api link
        urlString = urlString.appending("&media=tvShow")
        
        //return a valid url using the appended urlString
        return URL(string: urlString)
        
    }
    
    //MARK: Fetch Show
    
    //function to fetch the shows from the search result
    func fetchShows(from url: URL, for searchString: String) {
        
        //create dataTask
        let showTask = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            //check for an error and display it
            if let dataError = error {
                print("Could not fetch tv shows: \(dataError.localizedDescription)")
            } else {
                
                do {
                    //check for data
                    guard let someData = data else { return }
                    
                    //add JSONDecoder to decode JSON data
                    let jsonDecoder = JSONDecoder()
                    //decode the shows the from the search
                    let downloadedResults = try jsonDecoder.decode(Shows.self, from: someData)
                    //access the decoded results
                    self.showResults = downloadedResults.results
                    } catch let error {
                        //print error if JSON decoder fails
                        print("Problem decoding: \(error)")
                        }
            
                DispatchQueue.main.async {
                    //reload the table view data
                    self.tableView.reloadData()
                }
            }
        }
        //resume the dataTask
        showTask.resume()
    }
    
    //MARK: Fetch Image
    
    //function to fetch the images for the corresponding shows
    func fetchImage(for path: String, in cell: ShowTableViewCell) {
        
        //declare the image path from the show object
        let imagePath = path
        
        //check for the imageUrl
        guard let imageUrl = URL(string: imagePath) else {
            print("Can't find the url from \(imagePath)")
            return
        }
        
        //create downloadTask
        let imageFetch = URLSession.shared.downloadTask(with: imageUrl) {
            url, response, error in
            
            //check for no errors, declare the url and try to load an image with the url
            if error == nil, let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {

                DispatchQueue.main.async {
                //display the image in the UIImageView
                cell.showImageView.image = image
                }
            }
        }
        //resume the downloadTask
        imageFetch.resume()
    }
    
    //MARK: Navigation Method
    
    //function to navigate from the current controller to the detail controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //check for a valid selected row
        guard let selectedIndex = tableView.indexPathForSelectedRow else { return }

        //selected row is the selected index from the showResults array
        let selectedShow = showResults[selectedIndex.row]
        //navigate to the DetailViewController
        let destinationVC = segue.destination as! DetailViewController
        
        //load the show and showStore to the DetailViewController
        destinationVC.show = selectedShow
        destinationVC.showStore = showStore

    }

}

//MARK: SearchBar Method
extension ViewController: UISearchBarDelegate {
    
    //function for when the search request is send
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //check for text in the searchbar
        guard let searchQuery = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        
        //check if an api request can be made with the searchbar text
        if let showURL = createShowURL(from: searchQuery) {
            //fetch the shows with the created url
            fetchShows(from: showURL, for: searchQuery)
        }
        
        searchBar.resignFirstResponder()
    }
    
}

//MARK: Table View Methods
extension ViewController: UITableViewDelegate {
    
    //deselect the row that the indexPath identifies
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: Table View Data Method
extension ViewController: UITableViewDataSource {
    
    //function to declare the amount of rows are in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showResults.count
    }
    
    //function to populate the table view cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowCell", for: indexPath) as! ShowTableViewCell
        
        //show variable to grab the json data for each row
        let show = showResults[indexPath.row]
        
        //set the data accordingly from the show variable
        cell.collectionTitleLabel.text = show.collectionName
        cell.trackNameLabel.text = show.trackName
        cell.artistNameLabel.text = show.artistName
        cell.priceLabel.text = "$\(show.trackPrice)"
        
        //check if the show artwork exists
        if let showImage = show.artworkUrl100 {
            //fetch the artwork to load into the table view cell
            fetchImage(for: showImage, in: cell)
        }
        
        return cell
    }
    
}
