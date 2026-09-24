<?php
// Keep real credentials outside the document root and Git repository.
function connectDatabase()
{
    $configPath = getenv('COLORS_CONFIG_PATH') ?: dirname(__DIR__, 2) . '/colors-config.php';
    $config = require $configPath;
    return new mysqli(...$config);
}
