//
//  ActivityViewController.swift
//  UIActivityController
//
//  Created by Mikhail Chuparnov on 12.01.2023.
//

import UIKit

class ActivityViewController: UIViewController {

    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.setTitle("Share", for: .normal)
        button.backgroundColor = .systemTeal
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let activityController: ActivityViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    private func setupLayout() {
        self.view.addSubview(button)
        
        self.button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 56),
            button.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc private func tapButton() {
        animationTapButton(self.button)
        let ac = UIActivityViewController(activityItems: ["its working"], applicationActivities: nil)
        present(ac, animated: true)
    }
    
    // анимация для кнопки
    func animationTapButton(_ button: UIButton){
        
        let time = 0.06
        
        let scale = 0.95
        
        UIView.animate(withDuration: time, delay: 0) {
            button.transform = button.transform.scaledBy(x: scale, y: scale)
        } completion: { handler in
            UIView.animate(withDuration: time, delay: 0) {
                button.transform = button.transform.scaledBy(x: 1/scale, y: 1/scale)
            } completion: { handler in
                
            }
        }
    }

}
