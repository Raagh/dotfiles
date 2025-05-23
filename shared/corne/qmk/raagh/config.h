#pragma once

#define SPLIT_USB_DETECT


// I often have the QMK bug where I need to flash the keyboard multiple times
// for it to take effect, this version helps me know if it was flashed or not
// I update this manually with every change like a caveman
#define KEYMAP_VERSION "Keymap: v1.0.12"

// Select hand configuration
#define MASTER_LEFT

#define TAPPING_TERM 200
#define TAPPING_TERM_PER_KEY
#define TAPPING_TERM_THUMB 270

// If you press a dual-role key, press another key, and then release the
// dual-role key, all within the tapping term, by default the dual-role key
// will perform its tap action. If the HOLD_ON_OTHER_KEY_PRESS option is
// enabled, the dual-role key will perform its hold action instead.
#define HOLD_ON_OTHER_KEY_PRESS

// When enabled, typing a mod-tap plus second within term will register as the mod-combo
// Ref: https://beta.docs.qmk.fm/using-qmk/software-features/tap_hold#permissive-hold 
// #define PERMISSIVE_HOLD

// Prevent keydown and keyup from firing on different layers
#define PREVENT_STUCK_MODIFERS

// Set the COMBO_TERM so low that I won't type the keys one after each other during normal typing.
// They would have be held together intentionally to trigger this.
#define COMBO_TERM 40
#define COMBO_COUNT 3

// These mostly affect my one-shot Shift key, providing a CapsLock alternative.
// I want a relatively low timeout, so if I accidentally type "Shift", I can pause just briefly and move on.
#define ONESHOT_TAP_TOGGLE 3  /* Tapping this number of times holds the key until tapped once again. */
#define ONESHOT_TIMEOUT 2000  /* Time (in ms) before the one shot key is released */

// They are intended to beep and flash during flashing
#define QMK_LED     D5
#define QMK_SPEAKER C6

// Enable RGB Lighting
#ifdef RGBLIGHT_ENABLE
    #define RGBLIGHT_EFFECT_BREATHING
    #define RGBLIGHT_EFFECT_RAINBOW_MOOD
    #define RGBLIGHT_EFFECT_RAINBOW_SWIRL
    #define RGBLIGHT_EFFECT_SNAKE
    #define RGBLIGHT_EFFECT_KNIGHT
    #define RGBLIGHT_EFFECT_CHRISTMAS
    #define RGBLIGHT_EFFECT_STATIC_GRADIENT
    #define RGBLIGHT_LIMIT_VAL 120
    #define RGBLIGHT_HUE_STEP 10
    #define RGBLIGHT_SAT_STEP 17
    #define RGBLIGHT_VAL_STEP 17
#endif

// Enable oled screens
#define OLED_FONT_H "keyboards/crkbd/lib/glcdfont.c"

