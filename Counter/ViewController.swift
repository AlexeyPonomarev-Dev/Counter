//
//  ViewController.swift
//  Counter
//
//  Created by Alexey Ponomarev on 15.03.2023.
//

import UIKit

enum ChangeString: String {
    case change = "Значение измененно на"
    case reset = "Значение сброшенно"
    case negativeDecrement = "попытка уменьшить значение счётчика ниже 0"
}

class ViewController: UIViewController {

    @IBOutlet weak var historyTextView: UITextView!
    @IBOutlet weak var counterLabel: UILabel!
    
    @IBOutlet weak var resetCounterButton: UIButton!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyTextView.layer.borderWidth = 1
        historyTextView.layer.cornerRadius = 12
        counterLabel.text = "0"
    }

    @IBAction func decrement(_ sender: Any) {
        if (counterLabel.text == "0") {
            setHistory(with: .negativeDecrement)

            return;
        }
        
        guard let text = counterLabel.text, let count = Int(text)  else { return }
        
        counterLabel.text = String(count - 1)
        setHistory(with: .change, and: "-1")

    }
    
    @IBAction func increment(_ sender: Any) {
        guard let text = counterLabel.text, let count = Int(text)  else { return }
        
        counterLabel.text = String(count + 1)
        
        setHistory(with: .change, and: "+1")
    }
    
    @IBAction func resetCount(_ sender: Any) {
        counterLabel.text = "0"
        
        setHistory(with: .reset)
    }
}

// MARK: private methods
extension ViewController {
    private func getCurrentTimeString() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        
        return dateFormatter.string(from: date)
    }
    
    private func setHistory(with string: ChangeString, and value: String? = nil)  {
        guard let historyText = historyTextView.text else { return }
        let time = getCurrentTimeString()
    
        
        historyTextView.text = "\(historyText) \n [\(time)]: \(string.rawValue) \(value ?? "")"
    }
}
