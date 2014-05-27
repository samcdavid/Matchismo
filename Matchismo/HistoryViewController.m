//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Sam McDavid on 5/26/14.
//  Copyright (c) 2014 Sam McDavid. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

/**
 *  Property to store the turnDescriptions so they may be displayed on screen.
 */
@property (strong, nonatomic, readonly) NSAttributedString *turnHistoryDescription;

@property (weak, nonatomic) IBOutlet UITextView *turnHistoryDescriptionTextView;

@end

@implementation HistoryViewController

// Property Methods

- (NSArray *)turnHistoryDescriptions {
    if (!_turnHistoryDescriptions) _turnHistoryDescriptions = [[NSArray alloc] init];
    return _turnHistoryDescriptions;
}

- (NSAttributedString *)turnHistoryDescription {
    NSMutableAttributedString *history = [[NSMutableAttributedString alloc] init];
    NSAttributedString *newLine = [[NSAttributedString alloc] initWithString:@"\n"];
    
    for (NSMutableAttributedString *turn in self.turnHistoryDescriptions) {
        [history appendAttributedString:turn];
        [history appendAttributedString:newLine];
        [history setAttributes:@{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleBody],
                                 
                                 NSForegroundColorAttributeName: [UIColor blackColor]}
                         range:NSMakeRange(0, [history length])];
    }
    
    return history;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.turnHistoryDescriptionTextView.attributedText = self.turnHistoryDescription;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.turnHistoryDescriptions = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
