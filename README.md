# BMI Calculator iOS App

A feature-rich iOS app to calculate your Body Mass Index (BMI), track your health, and see personalized advice.

## Features

- Calculate BMI using **weight and height**
- Display **BMI value, color-coded advice, ideal weight, and weight difference**
- Dynamic **ResultViewController** with pan and swipe-down gestures
- Input via **text fields or sliders**, values are synchronized
- Recalculate quickly with the Recalculate button
- Handles invalid or unrealistic input values gracefully

## How to Use

1. Open the app
2. Enter your height (cm or m) and weight (kg) using text fields or sliders
3. Tap "Calculate"
4. View:
   - Your **BMI**
   - **Advice** based on BMI range
   - **Ideal weight** and **weight difference**
   - **Color-coded background** for quick visual feedback
5. Swipe down or pan the result screen to dismiss
6. Tap "Recalculate" to try different values

## BMI Categories

- BMI < 18.5 → "Biraz daha yemelisin!" (blue)
- BMI 18.5–24.9 → "Oldukça fitsin" (green)
- BMI ≥ 25 → "Az ye!" (red)

## Technologies Used

- Swift
- UIKit
- iOS 13+

## Notes

- Ideal BMI is assumed to be 22.0
- Designed for personal health tracking
- Easy to extend with additional features like history, charts, or notifications
