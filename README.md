# Bit Coin
Aplicacao consumindo api [BitCoin](https://www.coinapi.io/)


## Motivacap
Praticar o uso do desing patern delegate e MVC


## Feature
- Maneira de transformar os dados retornando da api em strings e usar objeto String
- Para implementar desing patern delegataion usei operador optional assim ele não ira obrigar  ser inserido no construtor do struct
- Aprendi o uso do imageViewPicker
- Ele utiliza o delegate UIPickerViewDelegate para acessar os campos do picker view
- E o  UIPickerViewDataSource para preencher os campos do picker view
- Vantagem de usar o desing partern [delegation](https://en.wikipedia.org/wiki/Delegation_pattern) e compartilhar métodos ou propriedades sem precisar instanciar e reduzimos código
- Abaixo didUpdateBitCoin e didFailWithError possuem o suficiente para view countroler exibir os dados casso sucesso ou error, sem precisar repetir ou instanciar o delegate
- Preciso apenas o uso do self

```swift

//transformar os dados em string,tabem e bom para testar
//se deu sucesso a request
//let dataString = String(data: safeData,encoding: .utf8)


//bitCoinManager

var delegateBitCoin: BitCoinDelegate?
if let bitcoinData = jsonParse(safeData) {
	 delegateBitCoin?.didUpdateBitCoin(bitcoinData)
}

if error != nil {
	 delegateBitCoin?.didFailWithError(error!)
		return
}



//======================== 
// quem criou a logica de negocio foi na struct bitCoinManager
//	bitCoinModel.delegateBitCoin = self
//Delegate

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


//====================
//uipicker view

extension ViewController:UIPickerViewDataSource {
	
	//quantidade de colunas
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	//quantidade de linhas
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return bitCoinModel.countryBitCoin.count
	}
	
}

extension ViewController:UIPickerViewDelegate {
	
	//acessando o indice do valor selecionado no picker view
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		bitCoinModel.geIndexCountry(row)
	}
	
	//preenchendo os dados
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return bitCoinModel.countryBitCoin[row]
	}
}




```

