//
//  ChatTableViewController.h
//  xmpp
//
//  Created by Estefania Chavez Guardado on 9/9/16.
//  Copyright © 2016 Estefania Chavez Guardado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPPFramework.h"
#import "ChatBusinessController.h"
#import "IRosterDelegate.h"
#import "IChatRepresentationHandler.h"

@interface ChatTableViewController : UITableViewController
<UITableViewDelegate, UITableViewDataSource, IRosterDelegate, IChatRepresentationHandler>

@property (strong) ChatBusinessController * chatBusinessController;

@property (strong) NSMutableArray * messagesArray;
@property (strong) NSArray *viewModel;
@property (strong) NSDictionary * dataRoster;


@end
