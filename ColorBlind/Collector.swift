import SpriteKit

class Collector {
    weak var gameSystem: GameSystem?
    let node: CollectorNode
    let lane: Int
    
    init(gameSystem: GameSystem, lane: Int) {
        self.gameSystem = gameSystem
        self.lane = lane
        self.node = CollectorNode(gameSystem: gameSystem)
        self.node.position = gameSystem.collectorPositions[lane]
    }
}
