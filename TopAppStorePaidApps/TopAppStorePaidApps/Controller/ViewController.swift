//
//  ViewController.swift
//  VeganApp
//
//  Created by Tommaso Barbiero on 11/07/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating {
    
    
    // MARK: - Outlets
    let searchController = UISearchController()
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var navItem: UINavigationItem!
    
    
    // MARK: - Arrays
    private var entries = [Entry]()
    private var filteredEntries = [Entry]()
    
    
    // MARK: - View Function
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        
        downloadJSON() {
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
        
        navItem.title = "Apps"
        initSearchController()
    }
    
    
    // MARK: - TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchController.isActive) {
            return filteredEntries.count
        }
        return entries.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
        table.deselectRow(at: indexPath, animated: true)
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var app = entries[indexPath.row]
        
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        if(searchController.isActive) {
            app = filteredEntries[indexPath.row]
        } else {
            app = entries[indexPath.row]
        }
        
        cell.nameLabel.text = app.name.label
        
        cell.priceLabel.text = app.price.label
        cell.priceLabel.layer.masksToBounds = true
        cell.priceLabel.layer.cornerRadius = 13
        
        cell.iconImageView.downloaded(from: app.image[2].label)
        
        return cell
    }
    
    
    // MARK: - NavigationView Function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = self.table.indexPathForSelectedRow!
        
        if let destination = segue.destination as? DetailViewController {
            if(searchController.isActive) {
                destination.app = filteredEntries[indexPath.row]
            } else {
                destination.app = entries[indexPath.row]
            }
        }
    }
    
    
    // MARK: - Search Function
    func initSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        
        navItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        let searchText = searchBar.text!
        
        filterForSearchText(searchText: searchText)
    }
    
    
    func filterForSearchText(searchText: String) {
        
        filteredEntries = entries.filter { entry in
            
            let anyMatch = entry.name.label.lowercased().contains(entry.name.label.lowercased())
            
            if(searchController.searchBar.text != "") {
                let searchTextMatch = entry.name.label.lowercased().contains(searchText.lowercased())
                
                return searchTextMatch
            } else {
                return anyMatch
            }
        }
        table.reloadData()
    }
    
    
    // MARK: - API DATA Parsing Function
    func downloadJSON(completed: @escaping () -> ()){
        let urlJSON = "https://itunes.apple.com/us/rss/toppaidapplications/limit=200/json"
        guard let url = URL(string: urlJSON) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            guard error == nil else {return}
            do {
                let decoder = JSONDecoder()
                let APIResponse = try decoder.decode(Response.self, from: data)
                self.entries = APIResponse.feed.entry
                DispatchQueue.global(qos: .background).async{
                    completed()
                }
            } catch let error {
                print("Failed to decode JSON:", error)
            }
        }.resume()
    }
    
}
