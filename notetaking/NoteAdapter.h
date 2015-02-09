//
//  Note Adapter.h
//  notetaking
//
//  Created by India Dearlove on 07/02/2015.
//  Copyright (c) 2015 India Dearlove. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Note.h"

@interface NoteAdapter : NSObject

/*
 *  Creates a note with title and text
 */
- (void)createNotewithTitle:(NSString*)title withText:(NSString*)text;

/*
 * Updates a note with new title and text
 */
- (void)updateNote:(Note*)note withTitle:(NSString*)title withText:(NSString*)text;

/*
 *  Removes note with title (does nothing if not exists)
 */
- (void)deleteNote:(Note*)note;

/*
 *  Retrieves all notes.
 */
- (NSArray*)allNotes;

@end
