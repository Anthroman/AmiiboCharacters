//
//  CharacterTableViewCell.swift
//  AmiiboCharacters
//
//  Created by Anthroman on 3/26/20.
//  Copyright © 2020 Anthroman. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterGameLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    
    //MARK: - Properties
    
    var character: JMBCharacter? {
        didSet {
            updateViews()
        }
    }
    
    var characterImage: UIImage? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let character = character else {return}
        characterNameLabel.text = character.name
        characterGameLabel.text = character.game
        characterImageView.image = characterImage
    }
}
