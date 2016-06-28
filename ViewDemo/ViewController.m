//
//  ViewController.m
//  ViewDemo
//
//  Created by user on 16/6/28.
//  Copyright © 2016年 rrcc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *aRedView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.aRedView = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 100, 100)];
    self.aRedView.backgroundColor = [UIColor redColor];
    self.aRedView.userInteractionEnabled = YES;
    [self.view addSubview:self.aRedView];
    
    // 3s 运行后执行动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:10 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction animations:^{
            
            self.aRedView.layer.transform = CATransform3DMakeTranslation(0, 400, 0);
            
        } completion:^(BOOL finished) {
            nil;
        }];
        
    });
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"frame 1 %@",NSStringFromCGRect([self.aRedView frame]));
    
    NSLog(@"frame 2 %@",NSStringFromCGRect([self.aRedView.layer frame]));
    
    // 在运动时 点击view 你看到的是 呈现层layer 在移动
    // 前两个frame 在动画一开始就到终点了 见Log
    NSLog(@"frame 3 %@",NSStringFromCGRect([[self.aRedView.layer presentationLayer] frame]));
    
    
    UITouch *aTouch = touches.anyObject;
    CGPoint touchPoint = [aTouch locationInView:self.view];
    
    //这里使用 呈现层frame
    if (CGRectContainsPoint(((CALayer *)[self.aRedView.layer presentationLayer]).frame, touchPoint)) {
        
        NSLog(@"CLICKED ME !!");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
