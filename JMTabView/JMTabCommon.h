//  Created by Aron Cedercrantz.

/**
 * @brief Force a category to be loaded when an app starts up.
 *
 * Add this macro before each category implementation, so we don't have to use
 * -all_load or -force_load to load object files from static libraries that only contain
 * categories and no classes.
 * See http://developer.apple.com/library/mac/#qa/qa2006/qa1490.html for more info.
 * Also see https://github.com/jverkoey/nimbus for the source of this code snippet.
 */
#define JM_FIX_CATEGORY_BUG(name) @interface JM_FIX_CATEGORY_BUG_##name @end \
@implementation JM_FIX_CATEGORY_BUG_##name @end
