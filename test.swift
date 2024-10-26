
import Foundation

// Character class
class Character {
    var name: String
    var health: Int
    var resources: Int
    var location: String
    
    init(name: String) {
        self.name = name
        self.health = 100
        self.resources = 0
        self.location = "Starting Point"
    }
    
    func move(to newLocation: String) {
        location = newLocation
        print("\(name) moved to \(location).")
    }
    
    func completeQuest(quest: Quest) {
        if resources >= quest.resourceCost {
            resources -= quest.resourceCost
            print("\(name) completed the quest: \(quest.name) and gained \(quest.reward) resources!")
            resources += quest.reward
        } else {
            print("Not enough resources to complete the quest: \(quest.name).")
        }
    }
    
    func checkStatus() {
        print("Health: \(health), Resources: \(resources), Location: \(location)")
    }
}

// Quest class
class Quest {
    var name: String
    var resourceCost: Int
    var reward: Int
    
    init(name: String, resourceCost: Int, reward: Int) {
        self.name = name
        self.resourceCost = resourceCost
        self.reward = reward
    }
}

// Game class
class Game {
    var character: Character
    var sanctuary: String
    var quests: [Quest]
    
    init(characterName: String) {
        character = Character(name: characterName)
        sanctuary = "Sanctuary"
        
        // Initialize quests with resource costs and rewards
        quests = [
            Quest(name: "Collect Water", resourceCost: 0, reward: 5),
            Quest(name: "Plant Trees", resourceCost: 3, reward: 10),
            Quest(name: "Recycle Waste", resourceCost: 2, reward: 8),
            Quest(name: "Build Shelter", resourceCost: 5, reward: 15),
            Quest(name: "Find Food", resourceCost: 0, reward: 7)
        ]
    }
    
    func start() {
        print("Welcome, \(character.name)! Your journey to the \(sanctuary) begins now.")
        
        while character.location != sanctuary {
            character.checkStatus()
            print("Available quests:")
            for (index, quest) in quests.enumerated() {
                print("\(index + 1): \(quest.name) (Cost: \(quest.resourceCost), Reward: \(quest.reward))")
            }
            print("What would you like to do? (Enter quest number or type 'move' to go to Sanctuary)")
            
            if let choice = readLine() {
                if let questIndex = Int(choice), questIndex > 0 && questIndex <= quests.count {
                    let selectedQuest = quests[questIndex - 1]
                    character.completeQuest(quest: selectedQuest)
                } else if choice.lowercased() == "move" {
                    character.move(to: sanctuary)
                } else {
                    print("Invalid choice. Please choose again.")
                }
            }
        }
        
        print("Congratulations, \(character.name)! You've reached the Sanctuary!")
    }
}

// Main execution
print("Enter your character's name:")
if let name = readLine() {
    let game = Game(characterName: name)
    game.start()
} else {
    print("Invalid name. Game cannot start.")
}
