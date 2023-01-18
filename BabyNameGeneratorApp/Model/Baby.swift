//
//  Baby.swift
//  BabyNameGeneratorApp
//
//  Created by Eduardo Maia on 18/01/23.
//

import Foundation

struct Baby {
    var yearOfBirth: String
    var gender: String
    var ethnicity: String
    var name: String
    var numberOfBabies: String
    var rank: String
    
    init(yearOfBirth: String, gender: String, ethnicity: String, name: String, numberOfBabies: String, rank: String) {
        self.yearOfBirth = yearOfBirth
        self.gender = gender
        self.ethnicity = ethnicity
        self.name = name
        self.numberOfBabies = numberOfBabies
        self.rank = rank
    }
}
