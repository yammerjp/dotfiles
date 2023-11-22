#!/usr/bin/env php
<?php

while(!feof(STDIN)){echo mb_convert_encoding(fgets(STDIN),"UTF-8","EUC-JP");}
