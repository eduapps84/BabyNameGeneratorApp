//
//  BabyCard.swift
//  BabyNameGeneratorApp
//
//  Created by Eduardo Maia on 19/01/23.
//

import UIKit

final class BabyCard: UIView {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var babyNameLabel: UILabel!
    
    // MARK: - Property
    
    lazy var viewModel = {
        BabyCardViewModel()
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupNib()
    }
    
    convenience init(frame: CGRect, baby: Baby) {
        self.init(frame: frame)
        self.viewModel.baby = baby
        setupUI()
    }
    
    private func setupNib() {
        let nib = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)!
        
        guard let babyCard = nib[0] as? UIView else {
            return
        }
        
        babyCard.frame = self.bounds
        addSubview(babyCard)
    }
    
    // MARK: - Private functions
    
    private func setupUI() {
        nameLabel.text = "\(viewModel.nameTitle):"
        babyNameLabel.text = viewModel.baby?.name.capitalized
    }
}
