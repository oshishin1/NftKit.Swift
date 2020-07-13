import EthereumKit

class TokenFactory {
    private let wethAddress: Data

    init(networkType: NetworkType) {
        self.wethAddress = TokenFactory.wethAddress(networkType: networkType)
    }

    var etherToken: Token {
        .eth(wethAddress: wethAddress)
    }

    func token(contractAddress: Data) -> Token {
        .erc20(address: contractAddress)
    }

}

extension TokenFactory {

    private static func wethAddress(networkType: NetworkType) -> Data {
        let wethAddressHex: String

        switch networkType {
        case .mainNet: wethAddressHex = "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2"
        case .ropsten: wethAddressHex = "0xc778417E063141139Fce010982780140Aa0cD5Ab"
        case .kovan: wethAddressHex = "0xd0A1E359811322d97991E03f863a0C30C2cF029C"
        }

        return Data(hex: wethAddressHex)!
    }

}