//
//  DropitBehavior.h
//  oyun
//
//  Created by GBGYP-7 on 3.03.2016.
//  Copyright © 2016 GBGYP-7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropitBehavior : UIDynamicBehavior

-(void) addItem : (id <UIDynamicItem>) item;
-(void) removeItem : (id <UIDynamicItem>) item;

@end
