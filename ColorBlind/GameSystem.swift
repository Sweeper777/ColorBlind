import SpriteKit
import EZSwiftExtensions
import SwiftRandom

class GameSystem {
    weak var scene: GameScene?
    let blockPositions: [CGPoint]
    let collectorPositions: [CGPoint]
    let colors: [UIColor]
    let fallToYPosition: CGFloat
    let numberOfLanes = 4
    let laneWidth: CGFloat
    var fallSpeed: TimeInterval = 4
    var collectors: [Collector] = []
    
    func onLanded(_ block: Block) {
        
    }
    
    init(scene: GameScene) {
        self.scene = scene
        let laneWidth = scene.view!.w / CGFloat(numberOfLanes)
        let point1 = CGPoint(x: laneWidth, y: 0)
        let point2 = CGPoint.zero
        let convertedPoint1 = scene.bg.convert(scene.view!.convert(point1, to: scene), from: scene)
        let convertedPoint2 = scene.bg.convert(scene.view!.convert(point2, to: scene), from: scene)
        self.laneWidth = convertedPoint1.x - convertedPoint2.x
        
        let fallToYPosition = scene.bg.convert(scene.view!.convert(CGPoint(x: 0, y: scene.view!.h - laneWidth), to: scene), from: scene).y
        self.fallToYPosition = fallToYPosition
        
        var blockPositions = [CGPoint]()
        for i in 0..<numberOfLanes {
            let x = laneWidth * CGFloat(i) + laneWidth / 2
            blockPositions.append(CGPoint(x: x, y: 0))
        }
        self.blockPositions = blockPositions.map { scene.bg.convert(scene.view!.convert($0, to: scene), from: scene) }
        let collectorPositions = blockPositions.map { CGPoint(x: $0.x, y: scene.view!.h) }
        self.collectorPositions = collectorPositions.map { scene.bg.convert(scene.view!.convert($0, to: scene), from: scene) }
        var colors = [UIColor]()
        let randomHue = CGFloat.random()
        let complement = fmod(randomHue + 0.5, 1.0)
        colors.append(UIColor(hue: randomHue, saturation: 1.0, brightness: 1.0, alpha: 1.0))
        colors.append(UIColor(hue: complement, saturation: 1.0, brightness: 1.0, alpha: 1.0))
        self.colors = colors
        
    }
}
