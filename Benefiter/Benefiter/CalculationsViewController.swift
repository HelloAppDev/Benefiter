//
//  ViewController.swift
//  Benefiter
//
//  Created by Мария Изюменко on 14.10.2022.
//

import UIKit
import RxSwift
import RxCocoa

class CalculationsViewController: UIViewController {
    
    @IBOutlet var weightButtons: [UIButton]!
    
    @IBOutlet weak var topProductView: ProductView!
    @IBOutlet weak var centerProductView: ProductView!
    @IBOutlet weak var bottomProductView: ProductView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var gr1Button: UIButton!
    @IBOutlet weak var gr10Button: UIButton!
    @IBOutlet weak var gr100Button: UIButton!
    @IBOutlet weak var kg1Button: UIButton!

    var weightNumber: Int?
    
    let mathModule = Mathmodule()
    var activeTextField : UITextField? = nil
    let disposeBag = DisposeBag()
    let viewModel = TextFieldsViewModel()
    let bottomViewModel = BottomTextFields()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTextFieldsInitialSettings()
        setupShadow()
        //setupBindings()
        
        viewModel.isValidForm.bind(to: calculateButton.rx.isEnabled).disposed(by: disposeBag)

        calculateButton.setBackgroundColor(#colorLiteral(red: 0.4643478394, green: 1, blue: 0.7415928245, alpha: 1), for: .normal)

        calculateButton.setBackgroundColor(.lightGray, for: .disabled)
        
        [kg1Button, gr1Button, gr10Button, gr100Button].forEach { _button in
            _button?.titleLabel?.font = UIFont(name: "Roboto", size: 14)
        }

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
            
        
        self.calculateButton.layer.cornerRadius = view.frame.width / 13.8
        self.clearButton.layer.cornerRadius = view.frame.width / 13.8
        
        
        
        //let taps = weightButtons.enumerated().map {($0.0, $0.1.rx.tap)}
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        if bottomProductView.isHidden == false {
            let observable = Observable.merge(
                weightButtons[0].rx.tap.map { 0 },
                weightButtons[1].rx.tap.map { 1 },
                weightButtons[2].rx.tap.map { 2 },
                weightButtons[3].rx.tap.map { 3 }
            )
            
            observable.subscribe(onNext: { [self] _ in
                
                viewModel.isValidForm.bind(to: calculateButton.rx.isEnabled).disposed(by: disposeBag)
                
                calculateButton.setBackgroundColor(#colorLiteral(red: 0.4643478394, green: 1, blue: 0.7415928245, alpha: 1), for: .normal)
                
                calculateButton.setBackgroundColor(.lightGray, for: .disabled)
                    checkTF()
            }).disposed(by: disposeBag)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let observable = Observable.merge(
            weightButtons[0].rx.tap.map { 0 },
            weightButtons[1].rx.tap.map { 1 },
            weightButtons[2].rx.tap.map { 2 },
            weightButtons[3].rx.tap.map { 3 }
        )
        
        observable.subscribe(onNext: { [self] _ in
            
            viewModel.isValidForm.bind(to: calculateButton.rx.isEnabled).disposed(by: disposeBag)
            
            calculateButton.setBackgroundColor(#colorLiteral(red: 0.4643478394, green: 1, blue: 0.7415928245, alpha: 1), for: .normal)
            
            calculateButton.setBackgroundColor(.lightGray, for: .disabled)
            
            if topProductView.weightNumbersLabel.text != "" {
                setupBindings()
            }
        }).disposed(by: disposeBag)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        topProductView.productTextField.adjustsFontSizeToFitWidth = true
        topProductView.productTextField.minimumFontSize = 0.7
    }
    
    private func setupBindings() {
        
        topProductView.priceTextField.rx.text.bind(to: viewModel.topPriceFieldsSubject).disposed(by: disposeBag)
        topProductView.weightTextField.rx.text.bind(to: viewModel.topWeightFieldsSubject).disposed(by: disposeBag)
        centerProductView.priceTextField.rx.text.bind(to: viewModel.centerPriceFieldsSubject).disposed(by: disposeBag)
        centerProductView.weightTextField.rx.text.bind(to: viewModel.centerWeightFieldsSubject).disposed(by: disposeBag)
        
//        if bottomProductView.isHidden == false {
//            topProductView.priceTextField.rx.text.bind(to: bottomViewModel.topPriceFieldsSubject).disposed(by: disposeBag)
//            topProductView.weightTextField.rx.text.bind(to: bottomViewModel.topWeightFieldsSubject).disposed(by: disposeBag)
//            centerProductView.priceTextField.rx.text.bind(to: bottomViewModel.centerPriceFieldsSubject).disposed(by: disposeBag)
//            centerProductView.weightTextField.rx.text.bind(to: bottomViewModel.centerWeightFieldsSubject).disposed(by: disposeBag)
//
//            bottomProductView.priceTextField.rx.text.bind(to: bottomViewModel.bottomPriceFieldsSubject).disposed(by: disposeBag)
//            bottomProductView.weightTextField.rx.text.bind(to: bottomViewModel.bottomWeightFieldsSubject).disposed(by: disposeBag)
//            //bottomViewModel.isValidBottomForm.bind(to: calculateButton.rx.isEnabled).disposed(by: disposeBag)
//
////            calculateButton.setBackgroundColor(#colorLiteral(red: 0.4643478394, green: 1, blue: 0.7415928245, alpha: 1), for: .normal)
////
////            calculateButton.setBackgroundColor(.lightGray, for: .disabled)
//            }
        
        if topProductView.profitableLabel.isHidden == false || centerProductView.profitableLabel.isHidden == false || bottomProductView.profitableLabel.isHidden == false {
            self.clearButton.isHidden = false
            self.clearButton.setBackgroundColor(#colorLiteral(red: 0.9995715022, green: 0.9797177911, blue: 0.4615154266, alpha: 1), for: .normal)
            //self.calculateButton.isHidden = true
        } else {
            self.calculateButton.isHidden = false
            self.clearButton.isHidden = true
            //calculateButton.setBackgroundColor(#colorLiteral(red: 0.4643478394, green: 1, blue: 0.7415928245, alpha: 1), for: .normal)
        }
    }
    
    private func mainTextFieldsInitialSettings() {
        [self.topProductView.productTextField,
         self.centerProductView.productTextField,
         self.bottomProductView.productTextField
        ].forEach { field in
            field?.delegate = self
            field?.setLeftPaddingPoints(5)
            field?.adjustsFontSizeToFitWidth = true
            field?.minimumFontSize = 0.7
        }
    }
    
    private func setupShadow() {
        weightButtons.forEach { button in
            button.setShadow(1, 1, 0.12)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.numberOfLines = 1
        }
        [topProductView,
         centerProductView,
         bottomProductView].forEach { view in
            view?.setShadow(1, 1, 0.12)
        }
        plusButton.setShadow(1, 1, 0.15)
    }
    
    @IBAction func plusButtonAction(_ sender: UIButton) {
        checkTF()
        bottomProductView.isHidden.toggle()
        bottomProductView.fadeIn()
        bottomProductView.trashButton.isHidden = false
        bottomProductView.trashButton.addTarget(self, action: #selector(trashButtonTapped), for: .touchUpInside)
        if topProductView.priceNumbersLabel.isHidden == false {
            clearButton.isHidden = true
        }
        
        
    }
    
    func checkTF() {
        if bottomProductView.weightNumbersLabel.text != "" {
            topProductView.priceTextField.rx.text.bind(to: bottomViewModel.topPriceFieldsSubject).disposed(by: disposeBag)
            topProductView.weightTextField.rx.text.bind(to: bottomViewModel.topWeightFieldsSubject).disposed(by: disposeBag)
            centerProductView.priceTextField.rx.text.bind(to: bottomViewModel.centerPriceFieldsSubject).disposed(by: disposeBag)
            centerProductView.weightTextField.rx.text.bind(to: bottomViewModel.centerWeightFieldsSubject).disposed(by: disposeBag)
            
            bottomProductView.priceTextField.rx.text.bind(to: bottomViewModel.bottomPriceFieldsSubject).disposed(by: disposeBag)
            bottomProductView.weightTextField.rx.text.bind(to: bottomViewModel.bottomWeightFieldsSubject).disposed(by: disposeBag)
        }
        
    }
    
    @objc private func trashButtonTapped() {
        bottomProductView.isHidden = true
        if bottomProductView.priceNumbersLabel.isHidden != true {
        clearButton.isHidden = false
        }
    }
    
    @IBAction func topButtonsAction(_ sender: UIButton) {
        
        if sender.tag == 0 {
            sender.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 15)
            gr10Button.titleLabel?.font = UIFont(name: "Roboto", size: 14)
            gr100Button.titleLabel?.font = UIFont(name: "Roboto", size: 14)
            kg1Button.titleLabel?.font = UIFont(name: "Roboto", size: 14)
            grAction(sender)
        } else if sender.tag == 1 {
            sender.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 15)
            gr1Button.titleLabel?.font = UIFont(name: "Roboto", size: 14)
            gr100Button.titleLabel?.font = UIFont(name: "Roboto", size: 14)
            kg1Button.titleLabel?.font = UIFont(name: "Roboto", size: 14)
            grAction(sender)
        } else if sender.tag == 2 {
            sender.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 15)
            gr1Button.titleLabel?.font = UIFont(name: "Roboto", size: 14)
            gr10Button.titleLabel?.font = UIFont(name: "Roboto", size: 14)
            kg1Button.titleLabel?.font = UIFont(name: "Roboto", size: 14)
            grAction(sender)
        } else if sender.tag == 3 {
            sender.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 15)
            gr10Button.titleLabel?.font = UIFont(name: "Roboto", size: 14)
            gr100Button.titleLabel?.font = UIFont(name: "Roboto", size: 14)
            gr1Button.titleLabel?.font = UIFont(name: "Roboto", size: 14)
            grAction(sender)
        }
    }
    
    private func grAction(_ sender: UIButton) {
        [topProductView.weightNumbersLabel, centerProductView.weightNumbersLabel, bottomProductView.weightNumbersLabel].forEach { _label in
            _label?.isHidden = false
            _label?.text = sender.titleLabel?.text
            
            if sender.tag == 0 {
                _label?.text = String(1)
            } else if sender.tag == 1 {
                _label?.text = String(10)
            } else if sender.tag == 2 {
                _label?.text = String(100)
            } else if sender.tag == 3 {
                _label?.text = String(1000)
            }
        }
    }
    
    @IBAction func calculateAction(_ sender: UIButton) {
                
        if topProductView.weightNumbersLabel.text != "" {
        if let topPrice = Int(topProductView.priceTextField.text!),
           let topWeight = Int(topProductView.weightTextField.text!),
           let weightNumber = Int(topProductView.weightNumbersLabel.text!) {
            let result = (weightNumber * topPrice) / topWeight
            topProductView.priceNumbersLabel.isHidden = false
            topProductView.priceNumbersLabel.text = "\(result)"
        }
        
        if let centerPrice = Int(centerProductView.priceTextField.text!),
           let centerWeight = Int(centerProductView.weightTextField.text!),
           let weightNumber = Int(topProductView.weightNumbersLabel.text!) {
            let result = (weightNumber * centerPrice) / centerWeight
            centerProductView.priceNumbersLabel.isHidden = false
            centerProductView.priceNumbersLabel.text = "\(result)"
            
        }
        
        if bottomProductView.isHidden == false {
            
            if let bottomPrice = Int(bottomProductView.priceTextField.text!),
               let bottomPriceWeight = Int(bottomProductView.weightTextField.text!),
               let weightNumber = Int(bottomProductView.weightNumbersLabel.text!) {
                let result = (weightNumber * bottomPrice) / bottomPriceWeight
                bottomProductView.priceNumbersLabel.isHidden = false
                bottomProductView.priceNumbersLabel.text = "\(result)"
                
            }
            
            if Int(topProductView.priceNumbersLabel.text!) ?? 0 <
                Int(centerProductView.priceNumbersLabel.text!) ?? 0 &&
                Int(topProductView.priceNumbersLabel.text!) ?? 0 <
                Int(bottomProductView.priceNumbersLabel.text!) ?? 0 {
                self.clearButton.isHidden = false
                topProductView.profitableLabel.isHidden = false
            } else if Int(centerProductView.priceNumbersLabel.text!) ?? 0 <
                        Int(topProductView.priceNumbersLabel.text!) ?? 0 &&
                        Int(centerProductView.priceNumbersLabel.text!) ?? 0 <
                        Int(bottomProductView.priceNumbersLabel.text!) ?? 0  {
                self.clearButton.isHidden = false
                centerProductView.profitableLabel.isHidden = false
            } else if Int(bottomProductView.priceNumbersLabel.text!) ?? 0 <
                        Int(centerProductView.priceNumbersLabel.text!) ?? 0 &&
                        Int(bottomProductView.priceNumbersLabel.text!) ?? 0 <
                        Int(topProductView.priceNumbersLabel.text!) ?? 0 {
                self.clearButton.isHidden = false
                bottomProductView.profitableLabel.isHidden = false
            }
        } else {
            if Int(topProductView.priceNumbersLabel.text!) ?? 0 < Int(centerProductView.priceNumbersLabel.text!) ?? 0 {
                topProductView.profitableLabel.isHidden = false
                self.clearButton.isHidden = false
            } else {
                centerProductView.profitableLabel.isHidden = false
                self.clearButton.isHidden = false
            }
        }
    }
}
    
    @IBAction func clearButton(_ sender: UIButton) {
        self.calculateButton.isHidden = false
        self.clearButton.isHidden = true
        self.calculateButton.isSelected = false
        
        
//        topProductView.priceTextField.rx.text.bind(to: bottomViewModel.topPriceFieldsSubject).disposed(by: disposeBag)
//        topProductView.weightTextField.rx.text.bind(to: bottomViewModel.topWeightFieldsSubject).disposed(by: disposeBag)
//        centerProductView.priceTextField.rx.text.bind(to: bottomViewModel.centerPriceFieldsSubject).disposed(by: disposeBag)
//        centerProductView.weightTextField.rx.text.bind(to: bottomViewModel.centerWeightFieldsSubject).disposed(by: disposeBag)
//
//        bottomProductView.priceTextField.rx.text.bind(to: bottomViewModel.bottomPriceFieldsSubject).disposed(by: disposeBag)
//        bottomProductView.weightTextField.rx.text.bind(to: bottomViewModel.bottomWeightFieldsSubject).disposed(by: disposeBag)
//
//        viewModel.isValidForm.bind(to: calculateButton.rx.isEnabled).disposed(by: disposeBag)
//        calculateButton.setBackgroundColor(.lightGray, for: .disabled)
        
        
        [gr1Button, gr10Button, gr100Button, kg1Button].forEach { _button in
            _button?.titleLabel?.font = UIFont(name: "Roboto", size: 14)
            _button?.isSelected = false
        }
        
        [topProductView.profitableLabel,
         centerProductView.profitableLabel,
         bottomProductView.profitableLabel].forEach { _label in
            _label?.isHidden = true
        }
        
        [topProductView.productTextField,
         centerProductView.productTextField,
         bottomProductView.productTextField].forEach { _textField in
            _textField?.text = ""
        }
        
        [topProductView.priceTextField,
         centerProductView.priceTextField,
         bottomProductView.priceTextField,
         topProductView.weightTextField,
         centerProductView.weightTextField,
         bottomProductView.weightTextField].forEach { _textField in
            _textField?.text = ""
        }
        
        [topProductView.priceNumbersLabel,
         topProductView.weightNumbersLabel,
         centerProductView.priceNumbersLabel,
         centerProductView.weightNumbersLabel,
         bottomProductView.priceNumbersLabel,
         bottomProductView.weightNumbersLabel].forEach { _label in
            if let label = _label {
             label.text = ""
            }
        }
    }
}

extension CalculationsViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // set the activeTextField to the selected textfield
        self.activeTextField = textField
        
    }
    
    // when user click 'done' or dismiss the keyboard
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let newCharacters = NSCharacterSet(charactersIn: string)
//        return NSCharacterSet.decimalDigits
//    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        var shouldMoveViewUp = false
        
        // if active text field is not nil
        if let activeTextField = activeTextField {
            
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
            
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            
            // if the bottom of Textfield is below the top of keyboard, move up
            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }
        if(shouldMoveViewUp) {
            self.view.frame.origin.y = 0 - keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
}
