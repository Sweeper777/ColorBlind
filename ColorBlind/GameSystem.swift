import SpriteKit
import EZSwiftExtensions
import SwiftRandom

class GameSystem {
    weak var scene: GameScene?
    let lanePositions: [CGPoint]
    let colors: [UIColor]
    let fallToYPosition: CGFloat
    let numberOfLanes = 4
    let laneWidth: CGFloat
    var fallSpeed: TimeInterval = 4
    
    func onLanded(_ block: Block) {
        
    }
    
    init(scene: GameScene) {
        self.scene = scene
        laneWidth = scene.view!.w / CGFloat(numberOfLanes)
        var lanePositions = [CGPoint]()
        for i in 0..<numberOfLanes {
            let x = laneWidth * CGFloat(i) + laneWidth / 2
            lanePositions.append(CGPoint(x: x, y: 0))
        }
        self.lanePositions = lanePositions.map { scene.bg.convert(scene.view!.convert($0, to: scene), from: scene) }
        var colors = [UIColor]()
        let randomHue = CGFloat.random()
        let complement = fmod(randomHue + 0.5, 1.0)
        colors.append(UIColor(hue: randomHue, saturation: 1.0, brightness: 1.0, alpha: 1.0))
        colors.append(UIColor(hue: complement, saturation: 1.0, brightness: 1.0, alpha: 1.0))
        self.colors = colors
        
        fallToYPosition = scene.bg.convert(scene.view!.convert(CGPoint(x: 0, y: scene.view!.h - laneWidth), to: scene), from: scene).y
    }
}
