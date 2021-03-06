//
//  MainAssembly.m
//  xmpp
//
//  Created by Estefania Guardado on 26/10/2016.
//  Copyright © 2016 Estefania Chavez Guardado. All rights reserved.
//

#import "MainAssembly.h"

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "RosterViewController.h"
#import "ChatTableViewController.h"
#import "ChatViewController.h"

#import "XMPPBusinessController.h"
#import "RosterBusinessController.h"
#import "ContactBusinessController.h"
#import "ChatBusinessController.h"

#import "DAOUserDefaults.h"
#import "DAOUserRLM.h"
#import "DAOContactsRLM.h"

#import "UpdateValuesHandler.h"

@implementation MainAssembly
    
-(AppDelegate *)appDelegate{
    return [TyphoonDefinition withClass:[AppDelegate class]
                          configuration:^(TyphoonDefinition *definition) {
                              
        [definition injectProperty:@selector(window)
                              with:[self mainWindow]];
        [definition injectProperty:@selector(xmppBusinessController)
                              with:[self xmppBusinessController]];
        
        definition.scope = TyphoonScopeLazySingleton;
    }];
}

- (UIWindow *) mainWindow{
    return [TyphoonDefinition withClass:[UIWindow class]
                          configuration:^(TyphoonDefinition *definition) {
                              
        [definition useInitializer:@selector(initWithFrame:)
                        parameters:^(TyphoonMethod *initializer) {
                            [initializer injectParameterWith:
                             [NSValue valueWithCGRect:[[UIScreen mainScreen] bounds]]];
                        }];
    }];
}

-(XMPPBusinessController *) xmppBusinessController{
    return [TyphoonDefinition withClass:[XMPPBusinessController class]
                          configuration:^(TyphoonDefinition *definition) {
                              
        [definition injectProperty:@selector(xmppStream) with:[self xmppStream]];
        [definition injectProperty:@selector(xmppRosterStorage)
                              with:[self xmppRosterStorage]];
        [definition injectProperty:@selector(xmppRoster) with:[self xmppRoster]];
        
        [definition injectProperty:@selector(daoUser) with:[self daoUserRLM]];
        [definition injectProperty:@selector(infoRoster)
                              with:[self rosterBusinessController]];
        
        definition.scope = TyphoonScopeLazySingleton;
    }];
}
    
-(XMPPStream *) xmppStream{
    return [TyphoonDefinition withClass:[XMPPStream class]
                          configuration:^(TyphoonDefinition *definition) {
                              
        definition.scope = TyphoonScopeLazySingleton;
    }];
}

-(XMPPRoster *) xmppRoster{
    return [TyphoonDefinition withClass:[XMPPRoster class]
                          configuration:^(TyphoonDefinition *definition) {
                              
        [definition useInitializer:@selector(initWithRosterStorage:)
                        parameters:^(TyphoonMethod *initializer) {
                            [initializer injectParameterWith:[self xmppRosterStorage]];
                        }];
                              
        definition.scope = TyphoonScopeLazySingleton;
    }];
}
    
-(XMPPRosterCoreDataStorage *) xmppRosterStorage{
    return [TyphoonDefinition withClass:[XMPPRosterCoreDataStorage class]
                          configuration:^(TyphoonDefinition *definition) {
                              
        [definition useInitializer:@selector(initWithDatabaseFilename:storeOptions:)
                        parameters:^(TyphoonMethod *initializer) {
                            [initializer injectParameterWith:nil];
                            [initializer injectParameterWith:nil];
                        }];
                              
        definition.scope = TyphoonScopeLazySingleton;
    }];
}
    
- (DAOUserDefaults *) daoUserDefaults{
    return [TyphoonDefinition withClass:[DAOUserDefaults class]
                          configuration:^(TyphoonDefinition *definition) {
                              
        definition.scope = TyphoonScopeLazySingleton;
    }];
}
    
- (LoginViewController *) loginViewController{
    return [TyphoonDefinition withClass:[LoginViewController class]
                          configuration:^(TyphoonDefinition *definition){
                              
        [definition injectProperty:@selector(xmppBusinessController)
                              with:[self xmppBusinessController]];
        [definition injectProperty:@selector(daoUser) with:[self daoUserRLM]];

        definition.scope = TyphoonScopeLazySingleton;
    }];
}

- (RosterViewController *) rosterViewController{
    return [TyphoonDefinition withClass:[RosterViewController class]
                          configuration:^(TyphoonDefinition *definition){
                              
        [definition injectProperty:@selector(daoUser) with:[self daoUserRLM]];
        [definition injectProperty:@selector(daoContact) with:[self daoContactsRLM]];
        [definition injectProperty:@selector(xmppBusinessController)
                              with:[self xmppBusinessController]];
        [definition injectProperty:@selector(rosterBusinessController)
                              with:[self rosterBusinessController]];
        [definition injectProperty:@selector(contactBusinessController)
                              with:[self contactBusinessController]];

        definition.scope = TyphoonScopeLazySingleton;
    }];
}

- (ChatTableViewController *) chatTableViewController{
    return [TyphoonDefinition withClass:[ChatTableViewController class]
                          configuration:^(TyphoonDefinition *definition){
        
        [definition injectProperty:@selector(chatBusinessController)
                              with:[self chatBusinessController]];
       
        definition.scope = TyphoonScopePrototype;
    }];
}

- (RosterBusinessController *) rosterBusinessController{
    return [TyphoonDefinition withClass:[RosterBusinessController class]
                          configuration:^(TyphoonDefinition *definition) {
                              
        [definition injectProperty:@selector(message) with:[self xmppMessage]];
        [definition injectProperty:@selector(daoContact) with:[self daoContactsRLM]];

        definition.scope = TyphoonScopeLazySingleton;
    }];
}

- (ContactBusinessController *) contactBusinessController{
    return [TyphoonDefinition withClass:[ContactBusinessController class]
                          configuration:^(TyphoonDefinition *definition) {

         [definition injectProperty:@selector(daoContact) with:[self daoContactsRLM]];
         [definition injectProperty:@selector(updateValuesHandler) with:[self updateValuesHandler]];
                              
          definition.scope = TyphoonScopeLazySingleton;
                          }];
}

- (XMPPMessage *) xmppMessage{
    return [TyphoonDefinition withClass:[XMPPMessage class]
                          configuration:^(TyphoonDefinition *definition) {
                              
        definition.scope = TyphoonScopeLazySingleton;
    }];
}

- (DAOUserRLM *) daoUserRLM {
    return [TyphoonDefinition withClass:[DAOUserRLM class]
                          configuration:^(TyphoonDefinition *definition) {

                              [definition injectProperty:@selector(realm)
                                                    with:[self rlmRealm]];
                              
                              definition.scope = TyphoonScopeLazySingleton;
                          }];
}

- (DAOContactsRLM *) daoContactsRLM {
    return [TyphoonDefinition withClass:[DAOContactsRLM class]
                          configuration:^(TyphoonDefinition *definition) {
                              
                              [definition injectProperty:@selector(realm)
                                                    with:[self rlmRealm]];
                              
                              definition.scope = TyphoonScopeLazySingleton;
                          }];
}

- (RLMRealm *) rlmRealm{
    return [RLMRealm defaultRealm];
}

- (ChatBusinessController *) chatBusinessController{
    return [TyphoonDefinition withClass:[ChatBusinessController class]
                          configuration:^(TyphoonDefinition *definition) {
                              
            [definition injectProperty:@selector(xmppBusinessController)
                                  with:[self xmppBusinessController]];
            definition.scope = TyphoonScopePrototype;
                          
                          }];
}

- (ChatViewController *) chatViewController{
    return [TyphoonDefinition withClass:[ChatViewController class]
                          configuration:^(TyphoonDefinition *definition){
                              
        [definition injectProperty:@selector(chatBusinessController)
                                                    with:[self chatBusinessController]];
                              
        definition.scope = TyphoonScopePrototype;
                          }];
}

- (UpdateValuesHandler *) updateValuesHandler{
    return [TyphoonDefinition withClass:[UpdateValuesHandler class]
                          configuration:^(TyphoonDefinition *definition) {
                              
            definition.scope = TyphoonScopeLazySingleton;
                          }];
}

@end
