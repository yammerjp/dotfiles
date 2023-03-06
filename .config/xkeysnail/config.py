# -*- coding: utf-8 -*-

import re
from xkeysnail.transform import *

# define timeout for multipurpose_modmap
define_timeout(1)

# [Global modemap] Change modifier keys as in xmodmap
define_modmap({
    Key.RIGHT_META: Key.LEFT_CTRL,
    Key.F16: Key.MUHENKAN,
    Key.F17: Key.HENKAN,
})
