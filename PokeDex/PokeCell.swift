//
//  PokeCell.swift
//  PokeDex
//
//  Created by Bhagat Singh on 12/16/16.
//  Copyright © 2016 com.bhagat_singh. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImage : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    
    var pokemon : Pokemon!
    
    required init?(coder aDecoder : NSCoder){
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ pokemon: Pokemon){
        self.pokemon = pokemon
        thumbImage.image = UIImage(named:"\(self.pokemon.pokedexId)")
        nameLabel.text = self.pokemon.name.capitalized
    }
}
