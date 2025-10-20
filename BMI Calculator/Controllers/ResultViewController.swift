//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Atakan Tul on 8.10.2025.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var bmiValue : String?
    var advice: String?
    var color: UIColor?
    var idealWeightText: String?          // BU satırları EKLE
    var weightDifferenceText: String?
    private var originalY: CGFloat = 0
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var idealWeightLabel: UILabel!
    @IBOutlet weak var weightDifferenceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Label ayarları
        bmiLabel.text = bmiValue
        adviceLabel.text = advice
        view.backgroundColor = color
        
        idealWeightLabel.numberOfLines = 0
        idealWeightLabel.text = "İdeal kilon: \(idealWeightText ?? "-")"
        idealWeightLabel.textAlignment = .center
        idealWeightLabel.frame.size.width = view.frame.width - 40
        idealWeightLabel.center.x = view.center.x
        idealWeightLabel.sizeToFit()

        weightDifferenceLabel.numberOfLines = 0
        weightDifferenceLabel.text = "Kilo farkın: \(weightDifferenceText ?? "-")"
        weightDifferenceLabel.textAlignment = .center
        weightDifferenceLabel.frame.size.width = view.frame.width - 40
        weightDifferenceLabel.center.x = view.center.x
        weightDifferenceLabel.sizeToFit()
        
        //extended layout
        self.edgesForExtendedLayout = [.top, .bottom]
        // Gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown(_:)))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)

        switch gesture.state {
        case .began:
            originalY = view.frame.origin.y

        case .changed:
            if translation.y > 0 {
                view.frame.origin.y = originalY + translation.y
            }

        case .ended:
            if translation.y > 150 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Geri eski pozisyona dön
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin.y = self.originalY
                }
            }

        default:
            break
        }
    }
    @objc func handleSwipeDown(_ gesture: UISwipeGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
