//
//  XSafeAccessArray.m
//  Pods
//
//  Created by 金小白 on 16/8/16.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#define XSafeAssert(condition, desc) NSAssert(condition, desc)

@implementation NSObject (XSafeAccessSwizzle)

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

@implementation NSArray (XSafeAccess)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:@selector(objectAtIndex:) originClass:NSClassFromString(@"__NSArrayI") with:@selector(safeObjectAtIndexI:) newClass:self];
        [self swizzleInstanceMethod:@selector(objectAtIndex:) originClass:NSClassFromString(@"__NSArray0") with:@selector(safeObjectAtIndex0:) newClass:self];
    });
}

- (id)safeObjectAtIndexI:(NSInteger)index {
    if (index < self.count) {
        return [self safeObjectAtIndexI:index];
    }else {
        XSafeAssert(NO, @"index is beyond bounds!!! 数组越界！！！");
        return nil;
    }
}

- (id)safeObjectAtIndex0:(NSInteger)index {
    if (index < self.count) {
        return [self safeObjectAtIndex0:index];
    }else {
        XSafeAssert(NO, @"index is beyond bounds!!! 数组越界！！！");
        return nil;
    }
}

@end

@implementation NSMutableArray (XSafeAccess)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:@selector(objectAtIndex:) originClass:NSClassFromString(@"__NSArrayM") with:@selector(safeObjectAtIndexM:) newClass:self];
    });
}

- (id)safeObjectAtIndexM:(NSInteger)index {
    if (index < self.count) {
        return [self safeObjectAtIndexM:index];
    }else {
        XSafeAssert(NO, @"index is beyond bounds!!! 数组越界！！！");
        return nil;
    }
}

@end
