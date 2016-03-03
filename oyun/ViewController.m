//
//  ViewController.m
//  oyun
//
//  Created by GBGYP-7 on 3.03.2016.
//  Copyright © 2016 GBGYP-7. All rights reserved.
//

#import "ViewController.h"
#import "DropitBehavior.h"
@interface ViewController ()<UIDynamicAnimatorDelegate>
@property(strong,nonatomic) UIDynamicAnimator *animator;
@property(strong,nonatomic) DropitBehavior *dropItBehavior;


@end

@implementation ViewController
CGSize dropSize;
-(void) dynamicAnimatorDidPause:(UIDynamicAnimator *)animator{
    [self removeCompletedRows];
}
- (IBAction)tap:(UITapGestureRecognizer *)sender {
    
    [self drop];
}



-(UIDynamicAnimator*) animator{
    
    if(!_animator){
        _animator=[[UIDynamicAnimator alloc] initWithReferenceView: self.view];
    }
    return _animator;

}

-(DropitBehavior*) dropItBehavior{
    if(!_dropItBehavior) {
        _dropItBehavior=[[DropitBehavior alloc] init];
        [self.animator addBehavior:_dropItBehavior];
    }
    return _dropItBehavior;
}

-(void) drop{
    CGRect frame;
    frame.origin=CGPointZero;
    frame.size=dropSize;
    int x=(arc4random() % (int) self.view.bounds.size.width)/dropSize.width;
    frame.origin.x= x* dropSize.width;
    
    UIView *dropView = [[UIView alloc] initWithFrame:frame];
    dropView.backgroundColor = [self randomColor];
    [self.view addSubview:dropView];
    [self.dropItBehavior addItem:dropView];

}

-(UIColor*) randomColor{

    NSMutableArray *colors=[[NSMutableArray alloc] init];
    float INCREMENT = 0.05;
    for(float hue=0.0;hue<1.0; hue+=INCREMENT){
        UIColor *color=[ UIColor colorWithHue:hue saturation:0.5 brightness:0.8 alpha:1.0];
                        
                        [colors addObject:color];
    }
                        int randomColorIndex= rand() % [colors count];
                        
      return [colors objectAtIndex:randomColorIndex];
                        
                        
}
-(BOOL) removeCompletedRows{
    
    NSMutableArray *dropsToRemove = [[NSMutableArray alloc] init];
    
    for (CGFloat y=self.view.bounds.size.height-dropSize.height/2; y>0; y-=dropSize.height) {
        
        BOOL rowIsComplete=YES;
        NSMutableArray *dropsFound =[[NSMutableArray alloc] init];
        
        for (CGFloat x=dropSize.width/2; x<=self.view.bounds.size.width-dropSize.width/2; x+=dropSize.width) {
            UIView *hitView = [self.view hitTest:CGPointMake(x, y) withEvent:NULL];
            
            if ([hitView superview] == self.view) {
                [dropsFound addObject:hitView];
            } else {
                rowIsComplete = NO;
                break;
            }
        }
        if (![dropsFound count]) break;
        if (rowIsComplete) [dropsToRemove addObjectsFromArray:dropsFound];
    }
    
    if ([dropsToRemove count]) {
        for (UIView *drop in dropsToRemove) {
            [self.dropItBehavior removeItem:drop];
            
        }
        [self animateRemovingDrops:dropsToRemove];
    }
    return NO;
}

-(void) animateRemovingDrops:(NSArray*) dropsToRemove {
    [UIView animateWithDuration:0.5
                     animations:^{
                         for (UIView *drop in dropsToRemove) {
                             int x= (arc4random()%(int)self.view.bounds.size.width*5) - (int)self.view.bounds.size.width*2;
                             int y=self.view.bounds.size.height;
                             drop.center =CGPointMake(x,y);
                             
                         }
                     }
                     completion:^(BOOL finished){
                         [dropsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
                         
                     }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.animator.delegate=self;
    dropSize=CGSizeMake(self.view.bounds.size.width/8, self.view.bounds.size.width/8);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
