//
// Created by Leonid Nifantyev on 2019-07-05.
// Copyright (c) 2019 Nifantyev. All rights reserved.
//

import CoreData

class CoreDataStack {
  private var modelName: String
  
  init(modelName: String) {
    self.modelName = modelName
  }
  
  private lazy var storeContainer: NSPersistentContainer = {
    guard let modelURL = Bundle(for: type(of: self)).url(forResource: self.modelName, withExtension:"momd") else {
      fatalError("Error loading model from bundle")
    }
    
    guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
      fatalError("Error initializing mom from: \(modelURL)")
    }
    
    let container = NSPersistentContainer(name: self.modelName, managedObjectModel: mom)
    
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        assertionFailure("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  lazy var managedContext: NSManagedObjectContext = {
    return self.storeContainer.viewContext
  }()
  
  func saveContext () {
    guard self.managedContext.hasChanges else { return }
    
    do {
      try self.managedContext.save()
    } catch {
      let error = error as NSError
      assertionFailure("Unresolved error \(error), \(error.userInfo)")
    }
  }
}