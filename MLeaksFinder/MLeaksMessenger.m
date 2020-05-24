/**
 * Tencent is pleased to support the open source community by making MLeaksFinder available.
 *
 * Copyright (C) 2017 THL A29 Limited, a Tencent company. All rights reserved.
 *
 * Licensed under the BSD 3-Clause License (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
 *
 * https://opensource.org/licenses/BSD-3-Clause
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
 */

#import "MLeaksMessenger.h"

static __weak UIAlertView *alertView;
static __weak UIAlertController *alertController;

@implementation MLeaksMessenger

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message {
    [self alertWithTitle:title message:message delegate:nil additionalButtonTitle:nil];
}

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
              delegate:(id<UIAlertViewDelegate>)delegate
 additionalButtonTitle:(NSString *)additionalButtonTitle {
    if(@available(iOS 9, *)) {
        [alertController dismissViewControllerAnimated:NO completion:nil];
        UIAlertController *alertControllerTemp = [UIAlertController
                                             alertControllerWithTitle:title
                                             message:message
                                             preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertControllerTemp addAction:okAction];
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertControllerTemp animated:YES completion:nil];
        alertController = alertControllerTemp;
    } else {
        [alertView dismissWithClickedButtonIndex:0 animated:NO];
        UIAlertView *alertViewTemp = [[UIAlertView alloc] initWithTitle:title
                                                                message:message
                                                               delegate:delegate
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:additionalButtonTitle, nil];
        [alertViewTemp show];
        alertView = alertViewTemp;
    }
    
    NSLog(@"%@: %@", title, message);
}

@end
