//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController, UITextFieldDelegate {
    var calculatorBrain = CalculatorBrain()
    var idealWeightText: String?
    var weightDifferenceText: String?

    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Başlangıçta slider'daki değeri text field'da göster
        updateTextFields()
        // Text field’lar değişince slider’ı güncelle
        heightTextField.addTarget(self, action: #selector(heightTextChanged), for: .editingChanged)
        weightTextField.addTarget(self, action: #selector(weightTextChanged), for: .editingChanged)
        heightTextField.delegate = self
        weightTextField.delegate = self
        heightTextField.textAlignment = .center
        weightTextField.textAlignment = .center

        heightTextField.keyboardType = .decimalPad
        weightTextField.keyboardType = .decimalPad

        // Kullanıcı yazmayı bitirdiğinde tetiklenecek
        heightTextField.addTarget(self, action: #selector(heightTextFieldChanged), for: .editingDidEnd)

    }
    @objc func heightTextFieldChanged() {
        guard let rawHeightText = heightTextField.text,
              let rawHeight = Float(rawHeightText), rawHeight > 0 else {
            return
        }

        let heightInMeters = rawHeight / 100
        heightSlider.value = heightInMeters  // Slider'ı güncelle
        heightTextField.text = String(format: "%.2f", heightInMeters) // Metre formatında göster
    }
    func updateTextFields() {
        heightTextField.text = String(format: "%.2f", heightSlider.value)
        weightTextField.text = String(format: "%.0f", weightSlider.value)
    }
    // TextField değişince slider'ı güncelle
    @objc func heightTextChanged() {
        if let text = heightTextField.text,
           let value = Float(text),
           value >= heightSlider.minimumValue,
           value <= heightSlider.maximumValue {
            heightSlider.value = value
        }
    }

    @objc func weightTextChanged() {
        if let text = weightTextField.text,
           let value = Float(text),
           value >= weightSlider.minimumValue,
           value <= weightSlider.maximumValue {
            weightSlider.value = value
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Klavyeyi kapatır
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) // Ekrana dokununca klavyeyi kapatır
    }
    // Slider’lar değiştiğinde text field’ları güncelle
    @IBAction func heightSliderChanged(_ sender: UISlider) {
        heightTextField.text = String(format: "%.2f", sender.value)
    }

    @IBAction func weightSliderChanged(_ sender: UISlider) {
        weightTextField.text = String(format: "%.0f", sender.value)
    }

    @IBAction func calculatePressed(_ sender: UIButton) {
        // Kullanıcının girdiği metinleri al ve , → . ile normalize et
        let heightText = heightTextField.text?.replacingOccurrences(of: ",", with: ".") ?? ""
        let weightText = weightTextField.text?.replacingOccurrences(of: ",", with: ".") ?? ""

        // Float'a çevirmeye çalış
        guard let rawHeight = Float(heightText),
              let weight = Float(weightText),
              rawHeight > 0, weight > 0 else {
            // Geçersiz girişler varsa uyarı göster
            let alert = UIAlertController(title: "Hata", message: "Lütfen geçerli bir boy ve kilo giriniz.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default))
            present(alert, animated: true)
            return
        }

        // Girilen boy değeri cm olabilir → 100'e bölüp metreye çevir
        // 2.5 metreden uzun insan yok, o yüzden 3'ten büyükse cm'dir diyebiliriz
        let height: Float = rawHeight > 3 ? rawHeight / 100 : rawHeight
        calculatorBrain.calculateBMI(height: height, weight: weight)
        performSegue(withIdentifier: "goToResult", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.modalPresentationStyle = .overFullScreen

            let height = heightSlider.value
            let weight = weightSlider.value

            destinationVC.bmiValue = calculatorBrain.getBMIValue()
            destinationVC.advice = calculatorBrain.getAdvice()
            destinationVC.color = calculatorBrain.getColor()
            destinationVC.idealWeightText = calculatorBrain.getIdealWeight(height: height)
            destinationVC.weightDifferenceText = calculatorBrain.getWeightDifference(currentWeight: weight, height: height)
        }
    }
}

