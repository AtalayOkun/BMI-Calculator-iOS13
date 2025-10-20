//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Atakan Tul on 9.10.2025.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

import UIKit
struct CalculatorBrain {
    var bmi: BMI?
    private var height: Float = 0.0
    private var weight: Float = 0.0
    func getBMIValue() -> String{
        let bmiTo1DecimalPlace = String(format: "%.1f", bmi?.value ?? 0.0)
            return bmiTo1DecimalPlace
    }
    func getAdvice() -> String {
        return bmi?.advice ?? "No advice"
    }
    func getColor() -> UIColor {
        return bmi?.color ?? UIColor.white
    }
    func getIdealWeight(height: Float) -> String {
        let idealBMI: Float = 22.0
        let idealWeight = idealBMI * (height * height)
        return String(format: "%.1f kg", idealWeight)
    }

    func getWeightDifference(currentWeight: Float, height: Float) -> String {
        let idealBMI: Float = 22.0
        let idealWeight = idealBMI * (height * height)
        let diff = currentWeight - idealWeight
        let diffAbs = abs(diff)
        let status = diff > 0 ? "fazlan var" : "eksiğin var"
        return String(format: "%.1f kg \(status)", diffAbs)
    }
    mutating func calculateBMI(height: Float, weight: Float) {
        self.height = height
        self.weight = weight

        guard height > 0.1, weight > 0 else {
            bmi = BMI(value: 0.0, advice: "Geçersiz boy veya kilo değeri", color: .gray)
            return
        }

        let bmiValue = weight / (height * height)

        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue, advice: "Biraz daha yemelisin!", color: .blue)
        } else if bmiValue < 24.9 {
            bmi = BMI(value: bmiValue, advice: "Oldukça fitsin", color: .green)
        } else {
            bmi = BMI(value: bmiValue, advice: "Az ye!", color: .red)
        }
    }

}
