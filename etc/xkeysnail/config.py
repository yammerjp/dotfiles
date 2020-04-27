# -*- coding: utf-8 -*-

import re
from xkeysnail.transform import *

define_modmap({
    # Fnを押さなくてもEscキーを ` ~ に
    Key.ESC: Key.GRAVE,
    K("Shift-ESC"): K("Shift-GRAVE"),

    # vim like direction keys
    K("RAlt-h"): K("LEFT"),
    K("RAlt-j"): K("DOWN"),
    K("RAlt-k"): K("UP"),
    K("RAlt-l"): K("RIGHT")
})

define_multipurpose_modmap({
    # caps-lock: 単独でesc, 複数でctrl
    Key.CAPSLOCK: [Key.ESC, Key.LEFT_CTRL],

    # 左shift: 単独で英数, 複数でcmd
    Key.LEFT_SHIFT: [Key.MUHENKAN, Key.LEFT_CTRL],

    # 右shift: 単独でかな, 複数でcmd
    Key.RIGHT_CTRL: [Key.HENKAN, Key.RIGHT_CTRL],

    # SandS
    Key.SPACE: [Key.SPACE, Key.LEFT_SHIFT],

    # tab: 単独でtab, 複数でalt
    Key.TAB: [Key.TAB, Key.LEFT_ALT]
})

