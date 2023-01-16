//
//  TextFieldViewController.swift
//  UIActivityController
//
//  Created by Mikhail Chuparnov on 12.01.2023.
//

import UIKit

class TextFieldViewController: UIViewController {

    let textLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.text = "напиши и поделись"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.clipsToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.setTitle("поделиться", for: .normal)
        button.backgroundColor = .systemTeal
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        self.view.addSubview(textField)
        self.view.addSubview(button)
        self.view.addSubview(textLabel)

        self.button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset*2),
            textField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset*2),
            textField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -inset),
            button.heightAnchor.constraint(equalToConstant: 56),
            button.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: inset),
            textLabel.heightAnchor.constraint(equalToConstant: 48),
            textLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
            textLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -inset)
        ])
    }
    
    @objc private func tapButton() {
        button.animationTapButton()
        if textField.text?.count != 0 {
            let text = textField.text
            let ac = UIActivityViewController(activityItems: [text as Any], applicationActivities: nil)
            present(ac, animated: true)
        } else {
                let animation = CABasicAnimation(keyPath: "position")
                animation.duration = 0.07
                animation.repeatCount = 3
                animation.autoreverses = true
                animation.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - 10, y: textField.center.y))
                animation.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 10, y: textField.center.y))
                textField.layer.add(animation, forKey: "position")
        }
    }
    
    

}

extension UIButton {
    
    func animationTapButton(){
        
        let time = 0.06
        
        let scale = 0.95
        
        UIView.animate(withDuration: time, delay: 0) {
            self.transform = self.transform.scaledBy(x: scale, y: scale)
        } completion: { handler in
            UIView.animate(withDuration: time, delay: 0) {
                self.transform = self.transform.scaledBy(x: 1/scale, y: 1/scale)
            } completion: { handler in
                
            }
        }
    }
}
