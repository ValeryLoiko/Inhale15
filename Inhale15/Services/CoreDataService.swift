//
//  CoreDataService.swift
//  Inhale15
//
//  Created by Diana on 02/11/2024.
//

import Foundation
import CoreData

class CoreDataService {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BreathDataModel")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
          return persistentContainer.viewContext
      }
    
    func saveBreathSession(duration: Double, date: Date) {
        let breathSession = BreathSession(context: context)
        breathSession.duration = duration
        breathSession.date = date
        
        do {
            try context.save()
            print("Сохранено: длительность - \(duration) секунд, дата - \(date)")
        } catch let error as NSError {
            print("Не удалось сохранить сеанс: \(error), \(error.userInfo)")
        }
    }
    
    func fetchBreathSessions() -> [BreathSession] {
        let fetchRequest: NSFetchRequest<BreathSession> = BreathSession.fetchRequest()
        
        do {
            let sessions = try context.fetch(fetchRequest)
            return sessions
        } catch let error as NSError {
            print("Не удалось загрузить сеансы: \(error), \(error.userInfo)")
            return []
        }
    }
}
