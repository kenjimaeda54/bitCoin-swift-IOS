//
//  BitCoinModel.swift
//  ByteCoin
//
//  Created by kenjimaeda on 21/07/22.
//

import Foundation

protocol BitCoinDelegate {
	func didUpdateBitCoin(_ bitcoin: BitCoinModel)
	func didFailWithError(_ error:Error)
}

struct BitCoinManager {
	
	//nao esquece optional senao sera obrigado a inserior no contrutor do struct
	var delegateBitCoin: BitCoinDelegate?
	
	var countryBitCoin =  ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
	
	func geIndexCountry(_ indexCountry: Int) {
		let country = self.countryBitCoin[indexCountry]
		let url =   "https://rest.coinapi.io/v1/exchangerate/BTC/\(country)?apikey=2CDCE773-BE88-491F-ABA6-A2D3EB615448"
		
		fetchData(url)
	}
	
	// 1 criar a url
	// 2 criar a sessao
	// 3 criar a task
	// 4 parsear o json
	func fetchData(_ noSafeUrl:String) {
		let safeUrl = noSafeUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
		
		if let url = URL(string: safeUrl ?? noSafeUrl) {
			let session = URLSession(configuration: .default)
			
			let task = session.dataTask(with: url){(data,response,error) in
				
				if error != nil {
					delegateBitCoin?.didFailWithError(error!)
					return
				}
				
				if let safeData = data {
					//transformar os dados em string,tabem e bom para testar
					//se deu sucesso a request
					//					let dataString = String(data: safeData,encoding: .utf8)
					if let bitcoinData = jsonParse(safeData) {
						delegateBitCoin?.didUpdateBitCoin(bitcoinData)
					}
					
				}
				
			}
			
			task.resume()
		}
		
	}
	
	func jsonParse(_ data: Data) -> BitCoinModel? {
		let decoder = JSONDecoder()
		do {
			let response = try decoder.decode(BitCoinData.self, from: data)
			let country = response.asset_id_quote
			let rate = response.rate
			return BitCoinModel(rate: rate, country: country)
		}catch {
			delegateBitCoin?.didFailWithError(error)
			return nil
		}
	}
}
