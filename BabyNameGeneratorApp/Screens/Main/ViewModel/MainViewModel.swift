//
//  MainViewModel.swift
//  BabyNameGeneratorApp
//
//  Created by Eduardo Maia on 18/01/23.
//

import Foundation

protocol MainViewModelProtocol: AnyObject {
    func babyListFilled()
    func babyListFilledError(error: String)
    func setBaby(baby: Baby)
    func errorSearch()
}

class MainViewModel {

    // MARK: Property
    
    weak private var delegate: MainViewModelProtocol?
    
    private var babyNamesService: BabyNamesServiceProtocol
    
    var babies = [Baby]()
    var fromServer: Bool = false
    
    // MARK: Lifecycle
    
    init(withDelegate delegate: MainViewModelProtocol, babyNamesService: BabyNamesServiceProtocol = BabyNamesService()) {
        self.delegate = delegate
        self.babyNamesService = babyNamesService
    }
    
    // MARK: Public functions
    
    func initBabyList() {
        if fromServer {
            babyNamesService.fetchBabyList(completion: { list, error in
                if error.count > 0 {
                    self.delegate?.babyListFilledError(error: error)
                } else {
                    for baby in list {
                        self.babies.append(baby)
                    }
                    
                    self.delegate?.babyListFilled()
                }
            })
        } else {
            for babiesList in ConstantsHelper.namesList {
                let baby = Baby(yearOfBirth: babiesList[0], gender: babiesList[1], ethnicity: babiesList[2], name: babiesList[3], numberOfBabies: babiesList[4], rank: babiesList[5])
                babies.append(baby)
            }
            
            self.delegate?.babyListFilled()
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
