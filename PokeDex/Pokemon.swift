//
//  Pokemon.swift
//  PokeDex
//
//  Created by Bhagat Singh on 12/16/16.
//  Copyright © 2016 com.bhagat_singh. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon{
    private var _name : String!
    private var _pokedexId : Int!
    private var _description : String!
    private var _height : String!
    private var _weight : String!
    private var _type : String!
    private var _defense : String!
    private var _attack : String!
    private var _nextEvolutionText : String!
    private var _nextEvolutionId : String!
    private var _nextEvolutionName : String!
    private var _nextEvolutionLevel : String!
    private var _pokemonURL : String!
    
    var nextEvolutionId : String{
        if _nextEvolutionId == nil{
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionName : String{
        if _nextEvolutionName == nil{
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var nextEvolutionLevel : String{
        if _nextEvolutionLevel == nil{
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    var description : String{
        if _description == nil{
            _description = ""
        }
        return _description
    }
    
    var height : String{
        if _height == nil{
            _height = ""
        }
        return _height
    }
    
    var type : String{
        if _type == nil{
            _type = ""
        }
        return _type
    }
    
    var weight : String{
        if _weight == nil{
            _weight = ""
        }
        return _weight
    }
    
    var defense : String{
        if _defense == nil{
            _defense = ""
        }
        return _defense
    }

    
    var attack : String{
        if _attack == nil{
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionText : String{
        if _nextEvolutionText == nil{
            _nextEvolutionText = ""
        }
        return _nextEvolutionText
    }
    
    var name : String{
        if _name == nil{
            _name = ""
        }
        return _name
    }
    
    var pokedexId : Int{
        return _pokedexId
    }
    
    init(name:String, pokedexId:Int){
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonURL = "\(base_url)\(url_pokemon)\(self.pokedexId)/"
    }
    
    func downloadPokemonDetails(completed: @escaping downloadComplete){
        Alamofire.request(_pokemonURL, method: .get).responseJSON { (response) in
            if let dict = response.result.value as? Dictionary<String,AnyObject>{
                if let weight = dict["weight"] as? String{
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String{
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int{
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int{
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String,String>], types.count > 0{
                    if let name = types[0]["name"]{
                        self._type = name.capitalized
                    }
                    if types.count > 1{
                        for x in 1..<types.count{
                            if let name = types[x]["name"]{
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                
                }else{
                    self._type = ""
                }
                
                if let descriptions = dict["descriptions"] as? [Dictionary<String,String>], descriptions.count > 0 {
                    if let url = descriptions[0]["resource_uri"]{
                        let descriptionURL = "\(base_url)\(url)"
                        Alamofire.request(descriptionURL,method: .get).responseJSON{ (response) in
                            print("got here")
                            if let descDict = response.result.value as? Dictionary<String,AnyObject>{
                                if let desc = descDict["description"] as? String{
                                    let newDesc = desc.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    print(newDesc)
                                    self._description = newDesc
                                }
                            }
                            completed()
                        }
                    }
                }else{
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String,AnyObject>], evolutions.count > 0{
                    if let nextEvo = evolutions[0]["to"] as? String{
                        if nextEvo.range(of: "mega") == nil{
                            self._nextEvolutionName = nextEvo
                            
                            if let uri = evolutions[0]["resource_uri"] as? String{
                                let newString = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newString.replacingOccurrences(of: "/", with: "")
                                self._nextEvolutionId = nextEvoId
                                
                            }
                            
                            if let levelExists = evolutions[0]["level"]{
                                if let level = levelExists as? Int{
                                    self._nextEvolutionLevel = "\(level)"
                                }
                                
                            }else{
                                self._nextEvolutionLevel = ""
                            }
                        }
                    }
                }
            }
            completed()
        }
    }
}
