//
//  SearchCharactersTableViewController.swift
//  AmiiboCharacters
//
//  Created by Anthroman on 3/26/20.
//  Copyright © 2020 Anthroman. All rights reserved.
//

import UIKit

class SearchCharactersTableViewController: UITableViewController, UISearchBarDelegate {

    //MARK: - Outlets
    
    @IBOutlet weak var characterSearchBar: UISearchBar!
    
    //MARK: - Properties
    
    var characters: [JMBCharacter] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        characterSearchBar.delegate = self
    }
    
    //MARK: - Delegates
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = characterSearchBar.text else {return}
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        JMBCharacterController.shared().searchForCharacter(withSearchTerm: searchText) { (characters, error) in
            self.characters = characters
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.title = searchText
            }
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? CharacterTableViewCell else {return UITableViewCell() }

        let character = characters[indexPath.row]
        cell.character = character
        
        JMBCharacterController.shared().fetchCharacterImage(character) { (image) in
            DispatchQueue.main.async {
                cell.characterImage = image
            }
        }
        
        return cell
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
