#!/bin/bash
mkdir bootstrap build config src tests tools uploads
cd tests
mkdir integration unit
cd ..
touch .htaccess CHANGELOG.md README.md 

PACKAGES=( league/route league/container zendframework/zend-diactoros zendframework/zend-httphandlerrunner monolog/monolog guzzlehttp/guzzle hphio/api-cli hphio/util filp/whoops ext-pdo hphio/farret phpmailer/phpmailer )

for PACKAGE in ${PACKAGES[@]}
do
  composer require ${PACKAGE}
done

DEVPACKAGES=( phpunit/phpunit )

for PACKAGE in ${DEVPACKAGES[@]}
do
  composer require --dev ${PACKAGE}
done

ln -s vendor/phpunit/phpunit/phpunit .
chmod ./phpunit