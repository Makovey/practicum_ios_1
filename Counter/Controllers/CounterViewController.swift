//
//  CounterViewController.swift
//  Counter
//
//  Created by MAKOVEY Vladislav on 23.07.2023.
//

import UIKit

private struct Constant {
    static let commonCornerRadius: CGFloat = 12
    static let formatterPattern = "dd-MM-yyyy HH:mm:ss"
}

private extension String {
    static let logStartTitle = String(localized: "log_start")
    static let logValueChangedMinusTitle = String(localized: "log_value_changed_minus")
    static let logValueChangedPlusTitle = String(localized: "log_value_changed_plus")
    static let logResetTitle = String(localized: "log_reset")
    static let logChangeValueFailureTitle = String(localized: "log_value_changed_failure")
}

class CounterViewController: UIViewController {
    
    // MARK: - Dependencies
        
    private var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constant.formatterPattern
        return dateFormatter
    }()
    
    // MARK: - Properties
    
    @IBOutlet weak var logTextView: UITextView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    private var counterValue: Int = 0 {
        willSet {
            self.counterValue = newValue
            counterLabel.text = String(newValue)
        }
    }
    
    private var currentDate: String {
        dateFormatter.string(from: Date())
    }
    
    // MARK: - Actions
    
    @IBAction func minusButtonTapped() {
        guard counterValue >= 1 else {
            logMessage(with: .logChangeValueFailureTitle)
            return
        }
        counterValue -= 1
        logMessage(with: .logValueChangedMinusTitle)
    }
    
    @IBAction func plusButtonTapped() {
        counterValue += 1
        logMessage(with: .logValueChangedPlusTitle)
    }
    
    @IBAction func resetButtonTapped() {
        counterValue = 0
        logMessage(with: .logResetTitle)
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupInitialState()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        minusButton.layer.cornerRadius = Constant.commonCornerRadius
        plusButton.layer.cornerRadius = Constant.commonCornerRadius
        resetButton.layer.cornerRadius = Constant.commonCornerRadius
        
        logTextView.layer.borderWidth = 1
        logTextView.layer.borderColor = UIColor.label.cgColor
        logTextView.layer.cornerRadius = Constant.commonCornerRadius
    }
    
    private func setupInitialState() {
        logTextView.isEditable = false
        logTextView.insertText(.logStartTitle.withNewLine)
    }
    
    private func logMessage(with message: String) {
        logTextView.insertText("\(currentDate): \(message)".withNewLine)
        logTextView.scrollLogToLastElement()
    }
}
