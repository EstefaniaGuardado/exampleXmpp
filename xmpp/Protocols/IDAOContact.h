//
//  IDAOContact.h
//  xmpp
//
//  Created by Estefania Guardado on 16/11/2016.
//  Copyright © 2016 Estefania Chavez Guardado. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDAOContact <NSObject>

- (void)updateValues: (NSArray*) contacts;
- (NSArray *) getContacts;

@end
