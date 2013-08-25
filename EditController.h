//
//  EditController.h
//  GG
//
//  Created by Dmitriy Remezov on 24.08.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Films.h"
#import "DetailViewController.h";

@interface EditController : UIViewController <UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *editTitle;
@property (weak, nonatomic) IBOutlet UITextField *editYear;
@property (weak, nonatomic) IBOutlet UITextField *editGenre;
@property (weak, nonatomic) IBOutlet UIImageView *editImage;
@property (weak, nonatomic) IBOutlet UITextView *editDescription;

@property Films *film;
- (IBAction)cancelEditView:(id)sender;
- (IBAction)saveEditing:(id)sender;

@end
