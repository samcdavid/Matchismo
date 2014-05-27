//
//  HistoryViewController.h
//  Matchismo
//
//  Created by Sam McDavid on 5/26/14.
//  Copyright (c) 2014 Sam McDavid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryViewController : UIViewController

/**
 *  Property to store the turnDescriptions so they may be displayed on screen.
 */
@property (weak, nonatomic) NSAttributedString *turnHistoryDescriptions;

@end
