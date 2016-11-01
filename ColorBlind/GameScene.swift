import SpriteKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        view.ignoresSiblingOrder = true
        let bg = self.childNode(withName: "bg") as! SKSpriteNode
        let node = SKSpriteNode(color: UIColor.red, size: CGSize(width: 100, height: 100))
        node.position = bg.convert(view.convert(CGPoint.zero, to: self), from: self)
        node.anchorPoint = CGPoint(x: 0, y: 1)
        node.zPosition = 1000
        bg.addChild(node)
    }
}
