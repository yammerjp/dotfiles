# -*- coding: utf-8 -*-

import re
from xkeysnail.transform import *

define_modmap({
    # Fnを押さなくてもEscキーを ` ~ に
    Key.ESC: Key.GRAVE,
    K("Shift-ESC"): K("Shift-GRAVE"),

    # vim like direction keys
    # K("M-h"): K("left"),
    # K("M-j"): K("down"),
    # K("M-k"): K("up"),
    # K("M-l"): K("right")
})

define_multipurpose_modmap({
    # caps-lock: 単独でesc, 複数でctrl
    Key.CAPSLOCK: [Key.ESC, Key.LEFT_CTRL],

    # 左shift: 単独で英数, 複数でcmd
    Key.LEFT_SHIFT: [Key.MUHENKAN, Key.LEFT_CTRL],

    # 右shift: 単独でかな, 複数でcmd
    Key.RIGHT_SHIFT: [Key.HENKAN, Key.RIGHT_CTRL],

    # SandS
    Key.SPACE: [Key.SPACE, Key.LEFT_SHIFT],

    # tab: 単独でtab, 複数でalt
    Key.TAB: [Key.TAB, Key.RIGHT_ALT]
})

