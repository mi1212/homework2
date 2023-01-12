//
//  PickerViewController.swift
//  UIActivityController
//
//  Created by Mikhail Chuparnov on 12.01.2023.
//

import UIKit

class PickerViewController: UIViewController {

    var check = 10 {
        didSet {
            
        }
    }
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.text = "у тебя есть 10 попыток, братишка"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let picker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.setTitle("Check", for: .normal)
        button.backgroundColor = .systemTeal
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "safe-2-fill")
        image.contentMode = .scaleAspectFit
        image.tintColor = .systemTeal
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        picker.dataSource = self
        picker.delegate = self
    }

    private func setupLayout() {
        self.view.addSubview(button)
        self.view.addSubview(picker)
        self.view.addSubview(textLabel)
        self.button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            picker.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            picker.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            picker.heightAnchor.constraint(equalToConstant: 300),
            picker.widthAnchor.constraint(equalTo: self.view.widthAnchor)
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
        animationTapButton(self.button)
        if button.title(for: .normal) == "Share to friends"{
            let activityController = UIActivityViewController(activityItems: [textLabel.text ?? "nil"] , applicationActivities: nil)
            present(activityController, animated: true)
        } else {
            checkPassword()
        }
        
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
    
    private func checkPassword() {
        
        check -= 1
        textLabel.text = "Осталось попыток - \(check)"
        let firstInt = picker.selectedRow(inComponent: 0)
        let secondInt = picker.selectedRow(inComponent: 1)
        let thirdInt = picker.selectedRow(inComponent: 2)
        
        if firstInt == 3 && secondInt == 2 && thirdInt == 8 {
            picker.removeFromSuperview()
            button.setTitle("Share to friends", for: .normal)
            setupImageLayout()
            textLabel.text = "медвежатники в городе"
        } else {
            if check == 0 {
                loseGame()
                image.image = UIImage(named: "police-icon")
                button.removeFromSuperview()
                setupImageLayout()
            }
        }
    }
    
    private func setupImageLayout() {
        self.view.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            image.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4),
            image.heightAnchor.constraint(equalTo: self.view.widthAnchor),
        ])
    }
    
    private func loseGame() {
        picker.removeFromSuperview()
        textLabel.text = "полиция выехала"
    }

}

extension PickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        10
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
    
}

extension PickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

    }
}
