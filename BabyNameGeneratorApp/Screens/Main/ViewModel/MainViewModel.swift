//
//  MainViewModel.swift
//  BabyNameGeneratorApp
//
//  Created by Eduardo Maia on 18/01/23.
//

import Foundation

protocol MainViewModelProtocol: AnyObject {
    func setBaby(baby: Baby)
    func errorSearch()
}

class MainViewModel {

    // MARK: Property
    
    weak private var delegate: MainViewModelProtocol?
    
    private var babies = [Baby]()
    
    // MARK: Lifecycle
    
    init(withDelegate delegate: MainViewModelProtocol) {
        self.delegate = delegate
    }
    
    // MARK: Public functions
    
    func initBabyList() {
        for babiesList in NamesListHelper.namesList {
            let baby = Baby(yearOfBirth: babiesList[0], gender: babiesList[1], ethnicity: babiesList[2], name: babiesList[3], numberOfBabies: babiesList[4], rank: babiesList[5])
            babies.append(baby)
        }
    }
    
    func getRandomBaby(gender: Int) {
        if !babies.isEmpty {
            let filterMale = babies.filter { $0.gender.uppercased() == (gender == 0 ? "MALE" : "FEMALE") }
            
            if let randomBaby = filterMale.randomElement() {
                self.delegate?.setBaby(baby: randomBaby)
            } else {
                self.delegate?.errorSearch()
            }
        } else {
            self.delegate?.errorSearch()
        }
    }
}
