#include QMK_KEYBOARD_H

extern uint8_t is_master;

// markstos defines

enum custom_keycodes {
  QWERTY = SAFE_RANGE,
  LOWER,
  RAISE,
  FUNC,
  BACKLIT
};

enum combos {
  DF_TAB,
  JK_ESC
};

const uint16_t PROGMEM df_combo[] = {KC_D, KC_F, COMBO_END};
const uint16_t PROGMEM jk_combo[] = {KC_J, KC_K, COMBO_END};

combo_t key_combos[COMBO_COUNT] = {
  // Add tab to home row because we dont have enough keys
  [DF_TAB]    = COMBO(df_combo, KC_TAB),
  // For Vim, put Escape on the home row
  [JK_ESC]    = COMBO(jk_combo, KC_ESC),
};

#define _QWERTY 0
#define _LOWER 1
#define _RAISE 2
#define _FUNC 3

// For _QWERTY layer
#define OSM_LCTL OSM(MOD_LCTL)
#define OSM_LALT OSM(MOD_LALT)
// #define OSM_AGR  OSM(MOD_RALT)
#define OSL_FUN  OSL(_FUNC)
// #define GUI_ENT  GUI_T(KC_ENT)
#define LOW_SPC  LT(_LOWER, KC_SPC)
#define RSE_BSP  LT(_RAISE, KC_BSPC)
#define OSM_SFT  OSM(MOD_LSFT)

// For _RAISE layer
#define CTL_ESC  LCTL_T(KC_ESC)

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [_QWERTY] = LAYOUT_split_3x6_3( \
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
       KC_TAB,    KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,                     KC_Y    ,KC_U    ,KC_I    ,KC_O    ,KC_P    ,KC_DEL,\
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     OSM_LCTL,    KC_A,    KC_S,    KC_D,    KC_F,    KC_G,                     KC_H    ,KC_J    ,KC_K    ,KC_L    ,KC_SCLN ,KC_QUOT,\
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
 OSM(MOD_LSFT),   KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,                     KC_N    ,KC_M    ,KC_COMM ,KC_DOT  ,KC_SLSH ,OSL_FUN,\
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                         OSM_LALT,  KC_RGUI, LOW_SPC,   RSE_BSP ,KC_ENT  ,OSM_SFT \
                                      //`--------------------------'  `--------------------------'
  ),

  [_LOWER] = LAYOUT_split_3x6_3( \
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
      _______, KC_EXLM, KC_AT  , KC_HASH, KC_DLR , KC_PERC,                      KC_CIRC, KC_AMPR, KC_ASTR, KC_LPRN, KC_RPRN, _______,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
      _______, KC_1   , KC_2   , KC_3   , KC_4   , KC_5   ,                      KC_6   , KC_7   , KC_8   , KC_9   , KC_0   , _______,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
      _______, XXXXXXX, KC_TILD, KC_GRV , KC_LBRC, KC_LCBR,                      KC_RCBR, KC_RBRC, KC_COMM,  KC_DOT, KC_SLSH, _______,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                          KC_TRNS,  KC_TRNS,XXXXXXX,    RSE_BSP, KC_TRNS, KC_COLON \
                                      //`--------------------------'  `--------------------------'
    ),


  [_RAISE] = LAYOUT_split_3x6_3( \
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
      _______, KC_DEL , XXXXXXX, KC_UNDS, KC_PLUS, KC_PGUP,                      XXXXXXX, KC_PIPE, KC_BSLS, XXXXXXX, XXXXXXX, _______,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
      _______, KC_HOME, KC_END , KC_MINS, KC_EQL , KC_PGDN,                      KC_LEFT, KC_DOWN, KC_UP  , KC_RGHT, XXXXXXX, _______,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
      _______, XXXXXXX, XXXXXXX, KC_LT  , KC_GT  , KC_SCLN,                      XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, _______,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                          CTL_ESC, KC_TRNS, LOW_SPC,    XXXXXXX , KC_TRNS, KC_TRNS\
                                      //`--------------------------'  `--------------------------'
  ),

  [_FUNC] = LAYOUT_split_3x6_3( \
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
      KC_F1  , KC_F2  , KC_F3   , KC_F4 ,  KC_F5 , KC_F6  ,                      KC_F7  , KC_F8  , KC_F9  , KC_F10 , KC_F11 , KC_F12 ,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
      _______, KC_VOLU, KC_BRIU, KC_PSCR, KC_MPLY, KC_CAPS,                      RGB_MOD, RGB_HUI, RGB_SAI, RGB_VAI, RGB_TOG, _______,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
      _______, KC_VOLD, KC_BRID, XXXXXXX, XXXXXXX, QK_BOOT,                     RGB_RMOD, RGB_HUD, RGB_SAD, RGB_VAD, XXXXXXX, _______,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                          XXXXXXX, XXXXXXX, XXXXXXX,    XXXXXXX, XXXXXXX, XXXXXXX\
                                      //`--------------------------'  `--------------------------'
  )
};

uint16_t get_tapping_term(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
      case LT(_RAISE, KC_BSPC):
            return TAPPING_TERM_THUMB;
      case LT(_LOWER, KC_SPC):
            return TAPPING_TERM_THUMB;
      default:
            return TAPPING_TERM;
    }
}

// bool get_hold_on_other_key_press(uint16_t keycode, keyrecord_t *record) {
//     switch (keycode) {
//       case LT(_RAISE, KC_BSPC):
//             return false;
//       case LT(_LOWER, KC_SPC):
//             return false;
//         default:
//             return true;
//     }
// }
