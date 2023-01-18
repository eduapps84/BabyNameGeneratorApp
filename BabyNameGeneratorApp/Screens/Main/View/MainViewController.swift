//
//  ViewController.swift
//  BabyNameGeneratorApp
//
//  Created by Eduardo Maia on 18/01/23.
//

import UIKit

protocol MainViewDelegate: AnyObject {
    
}

class MainViewController: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var babyNameLabel: UILabel!
    
    // MARK: Property
    
    lazy var viewModel = {
        MainViewModel(withDelegate: self)
    }()
    
    weak var mainViewDelegate: MainViewDelegate?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
    }
    
    // MARK: Private functions
    
    private func setupViewModel() {
        viewModel.initBabyList()
    }
    
    // MARK: Actions
    
    @IBAction func male_action(_ sender: Any) {
        viewModel.getRandomBaby(gender: 0)
    }
    
    @IBAction func female_action(_ sender: Any) {
        viewModel.getRandomBaby(gender: 1)
    }
}

// MARK: MainViewModelProtocol

extension MainViewController: MainViewModelProtocol {
    func setBaby(baby: Baby) {
        babyNameLabel.text = baby.name.capitalized
    }
    
    func errorSearch() {
        babyNameLabel.text = ""
    }
}

