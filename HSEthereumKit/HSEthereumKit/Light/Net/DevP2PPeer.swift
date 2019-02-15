import Foundation

class DevP2PPeer {

    enum DevP2PPeerError: Error {
        case peerDoesNotSupportLES
    }

    weak var delegate: IDevP2PPeerDelegate?

    private let connection: IPeerConnection
    private let myKey: ECKey
    private let myListenPort: UInt32 = 30303

    var helloSent: Bool = false
    var helloReceived: Bool = false

    private var queue = DispatchQueue(label: "DevP2P", qos: .userInitiated)

    init(key: ECKey, node: Node) {
        self.myKey = key

        connection = Connection(node: node)
        connection.delegate = self
    }

    func proceedHandshake() {
        if helloSent {
            if helloReceived {
                delegate?.connectionEstablished()
                return
            }
        } else {
            let helloMessage = HelloMessage(peerId: myKey.publicKeyPoint.x + myKey.publicKeyPoint.y, port: myListenPort)
            connection.send(message: helloMessage)
            helloSent = true
        }
    }

    private func validatePeer(message: HelloMessage) throws {
        guard message.capabilities.contains(HelloMessage.lesCapability) else {
            throw DevP2PPeerError.peerDoesNotSupportLES
        }
    }

    private func handle(message: IMessage) throws {
        print("<<< \(message.toString())")

        switch message {
        case let helloMessage as HelloMessage: handle(message: helloMessage)
        case let pingMessage as PingMessage: handle(message: pingMessage)
        case let pongMessage as PongMessage: handle(message: pongMessage)
        case let disconnectMessage as DisconnectMessage: handle(message: disconnectMessage)
        default: delegate?.connection(didReceiveMessage: message)
        }
    }


    func handle(message: HelloMessage) {
        helloReceived = true

        do {
            try validatePeer(message: message)
        } catch {
            print(error)
            disconnect(error: error)
        }

        proceedHandshake()
    }

    func handle(message: PingMessage) {
        let message = PongMessage()
        connection.send(message: message)
    }

    func handle(message: PongMessage) {
    }

    func handle(message: DisconnectMessage) {
    }

}

extension DevP2PPeer {

    func connect() {
        connection.connect()
    }

    func disconnect(error: Error? = nil) {
        connection.disconnect(error: error)
    }

    func send(message: IMessage) {
        connection.send(message: message)
    }

}

extension DevP2PPeer: IConnectionDelegate {

    func connectionEstablished() {
        proceedHandshake()
    }

    func connectionKey() -> ECKey {
        return myKey
    }

    func connectionDidDisconnect(withError error: Error?) {
        delegate?.connectionDidDisconnect(withError: error)
    }

    func connection(didReceiveMessage message: IMessage) {
        queue.async {
            do {
                try self.handle(message: message)
            } catch {
                self.disconnect(error: error)
            }
        }
    }

}
