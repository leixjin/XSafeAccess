//
//  NSArray+XSafe.m
//  Pods
//
//  Created by 金小白 on 16/8/16.
//
//

#import "NSArray+XSafe.h"
#import <objc/runtime.h>

@implementation NSArray (XSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self swizzleInstanceMethod:@selector(objectAtIndex:) originClass:NSClassFromString(@"__NSArrayI") with:@selector(safeObjectAtIndex:) newClass:self];
        [self swizzleInstanceMethod:@selector(objectAtIndex:) originClass:NSClassFromString(@"__NSArray0") with:@selector(safe0ObjectAtIndex:) newClass:self];
    });
}

- (id)safeObjectAtIndex:(NSInteger)index {
    
    if (index < [self count]) {
        return [self safeObjectAtIndex:index];
    }else{
        NSLog(@"index is beyond bounds!!! 数组越界！！！");
        return nil;
    }
}

- (id)safe0ObjectAtIndex:(NSInteger)index {
    if (index < [self count]) {
        return [self safe0ObjectAtIndex:index];
    }else{
        NSLog(@"index is beyond bounds!!! 数组越界！！！");
        return nil;
    }
}

+ (BOOL)swizzleInstanceMethod:(SEL)originalSel originClass:(Class)originCls with:(SEL)newSel newClass:(Class)newCls {
    
    Method originalMethod = class_getInstanceMethod(originCls, originalSel);
    Method newMethod = class_getInstanceMethod(newCls, newSel);
    
    if (!originalMethod || !newMethod) return NO;
    
    class_addMethod(originCls,originalSel,class_getMethodImplementation(originCls, originalSel),method_getTypeEncoding(originalMethod));
    class_addMethod(newCls,newSel,class_getMethodImplementation(newCls, newSel),method_getTypeEncoding(newMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(originCls, originalSel),
                                   class_getInstanceMethod(newCls, newSel));
    return YES;
}

@end
