//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
<<<<<<< HEAD
#import <camera/CameraPlugin.h>
#import <fluttertoast/FluttertoastPlugin.h>
#import <path_provider/PathProviderPlugin.h>
#import <permission_handler/PermissionHandlerPlugin.h>
=======
#import <devicelocale/DevicelocalePlugin.h>
#import <package_info/PackageInfoPlugin.h>
#import <path_provider/PathProviderPlugin.h>
#import <permission_handler/PermissionHandlerPlugin.h>
#import <shared_preferences/SharedPreferencesPlugin.h>
>>>>>>> 056f8a9fea71045512b607fe9ec2f4a110035f83

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
<<<<<<< HEAD
  [CameraPlugin registerWithRegistrar:[registry registrarForPlugin:@"CameraPlugin"]];
  [FluttertoastPlugin registerWithRegistrar:[registry registrarForPlugin:@"FluttertoastPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
  [PermissionHandlerPlugin registerWithRegistrar:[registry registrarForPlugin:@"PermissionHandlerPlugin"]];
=======
  [DevicelocalePlugin registerWithRegistrar:[registry registrarForPlugin:@"DevicelocalePlugin"]];
  [FLTPackageInfoPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPackageInfoPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
  [PermissionHandlerPlugin registerWithRegistrar:[registry registrarForPlugin:@"PermissionHandlerPlugin"]];
  [FLTSharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharedPreferencesPlugin"]];
>>>>>>> 056f8a9fea71045512b607fe9ec2f4a110035f83
}

@end
