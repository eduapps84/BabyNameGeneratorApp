//
//  ViewController.swift
//  BabyNameGeneratorApp
//
//  Created by Eduardo Maia on 18/01/23.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var babiesStack: UIStackView!
    
    // MARK: Property
    
    lazy var viewModel = {
        MainViewModel(withDelegate: self)
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupViewModel()
    }
    
    // MARK: Private functions
    
    private func setupUI() {
        titleLabel.text = viewModel.chooseTitle
        
        guard var configMaleButton = maleButton.configuration else {
            return
        }
        
        guard var configFemaleButton = femaleButton.configuration else {
            return
        }
        
        configMaleButton.attributedTitle = (try? AttributedString(NSAttributedString(string: viewModel.maleTitle, attributes: [.font: FontHelper.roboto(type: .bold, size: 28)]), including: AttributeScopes.UIKitAttributes.self)) ?? AttributedString()
        configFemaleButton.attributedTitle = (try? AttributedString(NSAttributedString(string: viewModel.femaleTitle, attributes: [.font: FontHelper.roboto(type: .bold, size: 28)]), including: AttributeScopes.UIKitAttributes.self)) ?? AttributedString()
        
        maleButton.configuration = configMaleButton
        femaleButton.configuration = configFemaleButton
        
        LayoutHelper.showLoading(view: self.view)
    }
    
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
    func babyListFilled() {
        LayoutHelper.hideLoading(view: self.view)
    }
    
    func babyListFilledError(error: String) {
        let alert = UIAlertController(title: error, message: self.viewModel.alertMsg, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: self.viewModel.alertButton, style: UIAlertAction.Style.default, handler: { action in
            self.viewModel.initBabyList()
        }))
        
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true, completion: nil)
        })
    }
    
    func setBaby() {
        babiesStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        babiesStack.addArrangedSubview(self.viewModel.babyCard!)
    }
    
    func errorSearch() {
        babiesStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}

