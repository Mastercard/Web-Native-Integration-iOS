//
//  NewMerchantViewController.swift
//  WebViewNativeCommIos
//
//  Created by Kodakandla, Pradeep on 10/28/21.

import UIKit

class NewMerchantViewController: UIViewController {
    @IBOutlet var initView:RequestResponseView?
    @IBOutlet weak var networkView: NetworkView?
    
    @IBOutlet weak var scrollView: UIScrollView?

    @IBOutlet weak var contentView: UIView?
    @IBOutlet weak var webview: WebViewIntegration!
    @IBOutlet weak var idLookupVuew: RequestResponseView?
    @IBOutlet weak var initiateValidationView: RequestResponseView?
    @IBOutlet weak var otpView: RequestResponseView?
    @IBOutlet weak var cardView: CardView?
    @IBOutlet weak var getCardsView: GetCardsView?
    
    var srcDpaId = ""

    var initaiteValidationPickerView: UIPickerView = UIPickerView()
    var pickerRows = ["None", "Email", "Phone"]
    var cardList : [CardListItem] = []
    var selectedCard : CardListItem = CardListItem(srcDigitalCardId: nil, panLastFour: nil, descriptorName: nil, artUri: nil, panExpirationMonth: nil, panExpirationYear: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.webview.setup()
        self.initView?.updateView()
        self.idLookupVuew?.updateView()
        self.initiateValidationView?.updateView()
        self.otpView?.updateView()
        self.cardView?.updateView()
        self.getCardsView?.updateView()
        
        self.networkView?.layer.borderWidth = 0.5
        self.networkView?.layer.borderColor = UIColor.gray.cgColor
        self.loadInitiateValidatePickerView()
        
        self.cardView?.expTextField?.delegate = self
        self.networkView?.masterCardButton?.isChecked = true
    }
    
    var merchantRequest = MerchantRequests()
    
    var selectedCards: String {
        var cards:[String] = []
        
        if let isChecked = networkView?.masterCardButton?.isChecked, isChecked {
            cards.append("\"mastercard\"")
        }
        if let isChecked = networkView?.visaButton?.isChecked, isChecked {
            cards.append("\"visa\"")
        }
        if let isChecked = networkView?.amexButton?.isChecked, isChecked {
            cards.append("\"amex\"")
        }
        if let isChecked = networkView?.discoverButton?.isChecked, isChecked {
            cards.append("\"discover\"")
        }
        return cards.joined(separator: ",")
    }

    @IBAction func initializeSDK(_ sender: UIButton) {
        if selectedCards.count == 0 {
            showAlert(message: "Please select at least one network")
            return
        }
        
        if self.srcDpaId.count == 0 {
            showAlert(message: "Please provide srcDpaId")
            return
        }
        
        let initRequest = merchantRequest.initRequest(selectedCards: selectedCards,srcDpaId: self.srcDpaId)
        
        self.initView?.requestTextView?.text = initRequest
        self.webview.initSdk(request: initRequest, callback: { response  in
            self.initView?.responseTextView?.text = response
        })
    }
    
    @IBAction func idLookupButtonPressed(_ sender: Any) {
        guard let emailText = self.idLookupVuew?.inputTextField?.text, emailText.count > 0 else {
            showAlert(message: "please enter valid email")
            return
        }
        let idLookupRequest = """
        {
        "email": "\(emailText)"
        }
        """
        self.idLookupVuew?.requestTextView?.text = idLookupRequest
        self.webview.idLookup(request: idLookupRequest, callback: { response  in
            self.idLookupVuew?.responseTextView?.text = response
        })
    }

    @IBAction func initiateValidationButtonPressed(_ sender: Any) {
        let initiateValidationRequest = ""
        self.initiateValidationView?.requestTextView?.text = "Empty Request"
        self.webview.initiateValidation(request: initiateValidationRequest, callback: { response  in
            self.initiateValidationView?.responseTextView?.text = response
        })
    }
    
    @IBAction func otpValidateButtonPressed(_ sender: Any) {
        guard let otpText = self.otpView?.inputTextField?.text, otpText.count > 0 else {
            showAlert(message: "please enter OTP")
            return
        }
        
        let validateRequest = """
        {
        "value": "\(otpText)"
        
        }
        """
        self.otpView?.requestTextView?.text = validateRequest
        self.webview.validate(request: validateRequest, callback: { response  in
            guard let jsonResponse = response else {
                self.showAlert(message: "invalid otp validate response")
                return
            }
            self.otpView?.responseTextView?.text = jsonResponse
            
            do {
                //     Serialize card list
                let jsonStringifiedData = jsonResponse.data(using: .utf8)!
                let decoder = JSONDecoder()
                let getCardsResponse = try decoder.decode([MaskedCard].self, from: jsonStringifiedData)
                
                //     Populate card list
                let cardList = self.extractCardsFromResponse(getCardsResponse)
                self.cardList = cardList
                self.getCardsView?.cardsTableView?.reloadData()
                self.viewWillLayoutSubviews()
            } catch {
                print("json serialization error")
            }
        })
    }

    @IBAction func encryptCardButtonPressed(_ sender: Any) {
        guard let cardNumber = self.cardView?.cardNumberTextField?.text,
              let expiryDate = self.cardView?.expTextField?.text,
              let cvcCode = self.cardView?.cvcTextField?.text,
        cardNumber.count > 0,  expiryDate.count > 0, cvcCode.count > 0 else {
            self.showAlert(message: "please enter valid cardNumber and expiry date")
            return
        }
        let encryptCardRequest = self.merchantRequest.encryptCardRequest(cardNumber: cardNumber, expiryDate: expiryDate, cvc: cvcCode)
        self.cardView?.encryptCardView?.requestTextView?.text = encryptCardRequest
        self.webview.encryptCard(request: encryptCardRequest, callback: { response  in
            self.cardView?.encryptCardView?.responseTextView?.text = response
        })
    }
    

    @IBAction func checkoutWithNewCardButtonPressed(_ sender: Any) {
        guard let encryptedCardResponse = self.cardView?.encryptCardView?.responseTextView?.text,
              encryptedCardResponse.count > 0 else {
            self.showAlert(message: "Invalid encryptedCardResponse")
            return
        }
        UserDefaults.standard.set(networkView?.actionSheetButton?.isChecked, forKey: "isDCFActionSheet")
        self.contentView?.bringSubviewToFront(self.webview)
        self.webview.checkoutWithNewCard(request: encryptedCardResponse, callback: { response  in
            self.cardView?.checkoutWithNewCardView?.requestTextView?.text = encryptedCardResponse
            self.cardView?.checkoutWithNewCardView?.responseTextView?.text = response
            self.contentView?.sendSubviewToBack(self.webview)
        })
    }
        
    
    @IBAction func getCardsButtonPressed(_ sender: Any) {
        self.getCardsView?.requestTextView?.text = "Empty request"
        self.webview.getCards(callback: { response  in
            guard let jsonResponse = response, jsonResponse.count > 0 else {
                self.showAlert(message: "invalid cards response")
                return
            }
            self.getCardsView?.responseTextView?.text = response
            do {
                //     Serialize card list
                let jsonStringifiedData = jsonResponse.data(using: .utf8)!
                let decoder = JSONDecoder()
                let getCardsResponse = try decoder.decode([MaskedCard].self, from: jsonStringifiedData)
                
                //     Populate card list
                let cardList = self.extractCardsFromResponse(getCardsResponse)
                self.cardList = cardList
                self.getCardsView?.cardsTableView?.reloadData()
                self.viewWillLayoutSubviews()
            } catch {
                print("json serialization error")
            }
        })
    }
    
    
    @IBAction func checkoutWithCardButtonPressed(_ sender: Any) {
        
        guard let srcDigitalCardId = self.selectedCard.srcDigitalCardId else {
            self.showAlert(message:"Please select a card")
            return
        }
        let checkoutRequest = """
        {
        "srcDigitalCardId": "\(srcDigitalCardId)"
        }
        """
        UserDefaults.standard.set(networkView?.actionSheetButton?.isChecked, forKey: "isDCFActionSheet")
        self.getCardsView?.checkoutCardView?.requestTextView?.text = checkoutRequest
        self.contentView?.bringSubviewToFront(self.webview)
        self.webview.checkoutWithCard(request: checkoutRequest, callback: { response  in
            self.getCardsView?.checkoutCardView?.responseTextView?.text =  response
            self.contentView?.sendSubviewToBack(self.webview)
        })
    }
        
    func extractCardsFromResponse(_ maskedCards: [MaskedCard]) -> [CardListItem] {
        
        var cardList : [CardListItem] = []
        for card in maskedCards {
            let newCard = CardListItem(
                srcDigitalCardId: card.srcDigitalCardId ?? nil,
                panLastFour: card.panLastFour ?? nil,
                descriptorName: card.digitalCardData?.descriptorName ?? nil,
                artUri: card.digitalCardData?.artUri ?? nil,
                panExpirationMonth: card.panExpirationMonth ?? nil,
                panExpirationYear: card.panExpirationYear ?? nil)
            cardList.append(newCard)
        }
        return cardList
    }
}


extension NewMerchantViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CardListCell? = tableView.dequeueReusableCell(withIdentifier: "cardListCell") as? CardListCell
        let cardInfo = self.cardList[indexPath.row]
        
        cell?.presentationCardNameLabel.text = cardInfo.descriptorName
        
        if (cardInfo.panExpirationMonth != nil && cardInfo.panExpirationYear != nil) {
            cell?.cardInfoLabel.text = "***...\(String(describing: cardInfo.panLastFour!))\t\(String(describing: cardInfo.panExpirationMonth!))/\(String(describing: cardInfo.panExpirationYear!))"
        } else {
            cell?.cardInfoLabel.text = "***...\(String(describing: cardInfo.panLastFour!))\t\(String(describing: cardInfo.panExpirationMonth))/\(String(describing: cardInfo.panExpirationYear))"
        }

        let imageUrl : URL? = URL(string: cardInfo.artUri!)
        let imageData : Data? = try? Data(contentsOf: imageUrl!)
        cell?.cardArtView.image = UIImage(data: imageData!)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCard = cardList[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
    }
}

extension NewMerchantViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func loadInitiateValidatePickerView() {
        self.initiateValidationView?.inputTextField?.inputView = self.initaiteValidationPickerView
        self.initaiteValidationPickerView.delegate = self
        self.initaiteValidationPickerView.dataSource = self

        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelTapped))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        self.initiateValidationView?.inputTextField?.inputAccessoryView = toolBar
    }
    
    @objc func doneTapped() {
        self.initiateValidationView?.inputTextField?.resignFirstResponder()
    }

    @objc func cancelTapped() {
        self.initiateValidationView?.inputTextField?.resignFirstResponder()
    }


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerRows.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerRows[row]
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.initiateValidationView?.inputTextField?.text = pickerRows[row]
    }

}

extension NewMerchantViewController:UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
            return true
        }
        let updatedText = oldText.replacingCharacters(in: r, with: string)

        if string == "" {
            if updatedText.count == 2 {
                textField.text = "\(updatedText.prefix(1))"
                return false
            }
        } else if updatedText.count == 1 {
            if updatedText > "1" {
                return true
            }
        } else if updatedText.count == 2 {
            if updatedText <= "12" { //Prevent user to not enter month more than 12
                textField.text = "\(updatedText)/" //This will add "/" when user enters 2nd digit of month
            }
            return false
        } else if updatedText.count > 5 {
            return false
        }

        return true
    }
}
