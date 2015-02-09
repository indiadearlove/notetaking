//
//  Note.h
//  notetaking
//
//  Created by India Dearlove on 07/02/2015.
//  Copyright (c) 2015 India Dearlove. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * date_created;
@property (nonatomic, retain) NSDate * date_updated;

@end
