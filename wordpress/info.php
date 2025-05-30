<?php 
file_put_contents('/tmp/phpfpm.log', "PHP-FPM REACHED\n", FILE_APPEND);
phpinfo(); ?>