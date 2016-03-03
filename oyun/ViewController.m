//
//  ViewController.m
//  oyun
//
//  Created by GBGYP-7 on 3.03.2016.
//  Copyright © 2016 GBGYP-7. All rights reserved.
//

#import "ViewController.h"
#import "DropitBehavior.h"
@interface ViewController ()
@property(strong,nonatomic) UIDynamicAnimator *animator;
@property(strong,nonatomic) DropitBehavior *dropItBehavior;


@end

@implementation ViewController
CGSize dropSize;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    dropSize=CGSizeMake(self.view.bounds.size.width/8, self.view.bounds.size.width/8);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
