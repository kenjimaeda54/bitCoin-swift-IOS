//
//  ViewController.swift
//  ByteCoin
//
//  Created by kenjimaeda on 21/07/22.
//

import UIKit

class ViewController: UIViewController {
	
	var bitCoinManager = BitCoinManager()
	
	@IBOutlet weak var viewBitCoin: UIView!
	@IBOutlet weak var pickerView: UIPickerView!
	@IBOutlet weak var countryBitCoin: UILabel!
	@IBOutlet weak var valueCurrentBitCoin: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		bitCoinManager.delegateBitCoin = self
		pickerView.dataSource = self
		pickerView.delegate = self
		viewBitCoin.layer.cornerRadius = viewBitCoin.frame.height / 5
	}
	
}



extension ViewController:UIPickerViewDataSource {
	
	//quantidade de colunas
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	//quantidade de linhas
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return bitCoinManager.countryBitCoin.count
	}
	
}

extension ViewController:UIPickerViewDelegate {
	
	//acessando o indice do valor selecionado no picker view
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		bitCoinManager.geIndexCountry(row)
	}
	
	//preenchendo os dados
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return bitCoinManager.countryBitCoin[row]
	}
}

extension ViewController:BitCoinDelegate {
	func didUpdateBitCoin(_ bitcoin: BitCoinModel) {
		DispatchQueue.main.async {
			self.countryBitCoin.text = bitcoin.country
			self.valueCurrentBitCoin.text = String(format: "%.2f",  bitcoin.rate)
		}
		
	}
	
	func didFailWithError(_ error: Error) {
		print(error)
	}
	
}
