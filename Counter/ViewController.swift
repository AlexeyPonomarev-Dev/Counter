//
//  ViewController.swift
//  Counter
//
//  Created by Alexey Ponomarev on 15.03.2023.
//

import UIKit

fileprivate enum ChangeString: String {
    case change = "Значение измененно на"
    case reset = "Значение сброшенно"
    case negativeDecrement = "попытка уменьшить значение счётчика ниже 0"
}

class ViewController: UIViewController {
    @IBOutlet private weak var historyTextView: UITextView!
    @IBOutlet private weak var counterLabel: UILabel!
    
    @IBOutlet private weak var resetCounterButton: UIButton!
    @IBOutlet private weak var decrementButton: UIButton!
    @IBOutlet private weak var incrementButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyTextView.layer.borderWidth = 1
        historyTextView.layer.cornerRadius = 12
        counterLabel.text = "0"
    }
    
    private func getCurrentDateString() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        
        return dateFormatter.string(from: date)
    }
    
    private func setHistory(with string: ChangeString, and value: String? = nil)  {
        guard let historyText = historyTextView.text else { return }
        let date = getCurrentDateString()
    
        historyTextView.text = "\(historyText) \n [\(date)]: \(string.rawValue) \(value ?? "")"
    }

    @IBAction private func decrement(_ sender: Any) {
        if (counterLabel.text == "0") {
            setHistory(with: .negativeDecrement)
            return
        }
        
        guard let text = counterLabel.text, let count = Int(text)  else { return }

        counterLabel.text = String(count - 1)
        setHistory(with: .change, and: "-1")
    }
    
    @IBAction private func increment(_ sender: Any) {
        guard let text = counterLabel.text, let count = Int(text)  else { return }

        counterLabel.text = String(count + 1)
        setHistory(with: .change, and: "+1")
    }
    
    @IBAction private func resetCount(_ sender: Any) {
        counterLabel.text = "0"
        setHistory(with: .reset)
    }
}
