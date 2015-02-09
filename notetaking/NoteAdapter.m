//
//  Note Adapter.m
//  notetaking
//
//  Created by India Dearlove on 07/02/2015.
//  Copyright (c) 2015 India Dearlove. All rights reserved.
//


#import "NoteAdapter.h"
#import "Note.h"

#import "AppDelegate.h"

@implementation NoteAdapter

- (void)createNotewithTitle:(NSString*)title withText:(NSString*)text {
    // Get our managed object context - the world our objects live in
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    // Obtain entity description
    NSManagedObjectModel *managedObjectModel = [[moc persistentStoreCoordinator] managedObjectModel];
    NSEntityDescription *entity = [[managedObjectModel entitiesByName] objectForKey:@"Note"];
    
    // Create a new note
    Note *note = [[Note alloc] initWithEntity:entity insertIntoManagedObjectContext:moc];
    
    // Set attributes for new note
    [note setTitle:title];
    [note setContent:text];
    
    // Store new note persisently
    [self saveChanges];
}

- (void)updateNote:(Note*)note withTitle:(NSString*)title withText:(NSString*)text {
    // Change object values
    [note setTitle:title];
    [note setContent:text];
    // Make changes persistent
    [self saveChanges];
}

- (void)deleteNote:(Note*)note {
    // We delete the note from the current context
    [[self managedObjectContext] deleteObject:note];
    // Make persistent
    [self saveChanges];
}

- (NSArray*)allNotes {
    // Get our managed object context - the world our objects live in
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    // Define which objects we want to retrieve - Notes in this case
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Note" inManagedObjectContext:moc];
    
    // Create a request which retrieves our notes
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    // Sort results
    NSSortDescriptor *sortByDateDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date_created" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sortByDateDescriptor]];
    
    // Execute request, retrieve notes, handle error
    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    if (array == nil)
    {
        NSLog(@"There has been an error while retrieving notes from Core Data");
    }
    
    return array;
}

- (NSManagedObjectContext*)managedObjectContext {
    return [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
}

- (void)saveChanges {
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] saveContext];
}


@end
