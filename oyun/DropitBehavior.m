//
//  DropitBehavior.m
//  oyun
//
//  Created by GBGYP-7 on 3.03.2016.
//  Copyright © 2016 GBGYP-7. All rights reserved.
//

#import "DropitBehavior.h"
@interface DropitBehavior()
@property(strong,nonatomic) UIGravityBehavior *gravity;
@property(strong,nonatomic) UICollisionBehavior *collider;
@property(strong,nonatomic) UIDynamicItemBehavior *animationOptions;



@end
@implementation DropitBehavior
-(UIDynamicItemBehavior*) animationOptions{
    if(!_animationOptions){
        _animationOptions=[[UIDynamicItemBehavior alloc] init];
        _animationOptions.allowsRotation=NO;
    }
    return _animationOptions;
}

-(UIGravityBehavior*) gravity{

    if(!_gravity){
        _gravity=[[UIGravityBehavior alloc] init];
        _gravity.magnitude=0.9;
    }
    return _gravity;

}

-(UICollisionBehavior*) collider{
    if(!_collider){
        _collider=[[UICollisionBehavior alloc] init];
        _collider.translatesReferenceBoundsIntoBoundary=YES;
    }
    return _collider;

}

-(void) addItem:(id<UIDynamicItem>)item{
    [self.gravity addItem: item];
    [self.collider addItem :item];
    [self.animationOptions addItem:item];

}

-(void) removeItem:(id<UIDynamicItem>)item{
    [self.gravity removeItem:item];
    [self.collider removeItem:item];

}

-(instancetype) init

{
    self = [super init];
    
    [self addChildBehavior:self.gravity];
    [self addChildBehavior:self.collider];
    [self addChildBehavior:self.animationOptions];
    return self;

}

@end
