//
//  PokemonDetailController.swift
//  PokeDex
//
//  Created by Bhagat Singh on 12/16/16.
//  Copyright © 2016 com.bhagat_singh. All rights reserved.
//

import UIKit

class PokemonDetailController: UIViewController {

    var pokemon : Pokemon!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexIdLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var evoLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var nextEvoImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = pokemon.name.capitalized
        
        pokemon.downloadPokemonDetails {
            print("Did arrive here?")
            //only be called after network call is complete!
            self.updateUI()
        }
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI(){
        attackLabel.text = pokemon.attack
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        pokedexIdLabel.text = "\(pokemon.pokedexId)"
        mainImage.image = UIImage(named:"\(pokemon.pokedexId)")
        currentEvoImage.image = UIImage(named:"\(pokemon.pokedexId)")
        typeLabel.text = pokemon.type
        descriptionLabel.text = pokemon.description.capitalized
        
        if pokemon.nextEvolutionId == ""{
            evoLabel.text = "No Evolutions"
            nextEvoImage.isHidden = true
        }else{
            nextEvoImage.isHidden = false
            nextEvoImage.image = UIImage(named:"\(pokemon.nextEvolutionId)")
            evoLabel.text = "Next Evolution: \(pokemon.nextEvolutionName) - LVL \(pokemon.nextEvolutionLevel)"
            
        }
    }
    
}
