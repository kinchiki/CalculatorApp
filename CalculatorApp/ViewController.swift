//
//  ViewController.swift
//  CalculatorApp
//
//  Created by 水野陽斗 on 2018/07/15.
//  Copyright © 2018 akitomizuno. All rights reserved.
//

import UIKit
import Expression

class ViewController: UIViewController {

    @IBOutlet weak var formulaLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        formulaLabel.text = ""
        answerLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func inputFormula(_ sender: UIButton) {
        guard let formulaText = formulaLabel.text else {
            return
        }
        guard let senderedText = sender.titleLabel?.text else {
            return
        }
        formulaLabel.text = formulaText + senderedText
    }

    @IBAction func clearCalculation(_ sender: UIButton) {
        formulaLabel.text = ""
        answerLabel.text = ""
    }

    @IBAction func calculateAnswer(_ sender: UIButton) {
        guard let formulaText = formulaLabel.text else {
            return
        }
        let formula: String = formatFormula(formulaText)
        answerLabel.text = evalFormula(formula)
    }

    private func formatFormula(_ formula: String) -> String {
        let formattedFormula: String = formula.replacingOccurrences(
                of: "(?<=^|[÷×\\+\\-\\(])([0-9]+)(?=[÷×\\+\\-\\)]|$)",
                with: "$1.0",
                options: NSString.CompareOptions.regularExpression,
                range: nil
            ).replacingOccurrences(of: "÷", with: "/").replacingOccurrences(of: "×", with: "*")
        return formattedFormula
    }

    private func evalFormula(_ formula: String) -> String {
        do {
            let expression = Expression(formula)
            let answer = try expression.evaluate()
            return formatAnswer(String(answer))
        } catch {
            return "invaild formula!"
        }
    }
}
