#!/bin/bash
function build_skel() {
    echo "Building skeleton..."
    mkdir bootstrap build config src tests tools uploads
    cd tests
    mkdir integration unit
    cd ..
    touch .htaccess CHANGELOG.md README.md
}

function run_composer() {
    echo "Running composer..."
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
}

function setup_phpunit () {
    echo "Setting up PHPUnit..."
    ln -s vendor/phpunit/phpunit/phpunit .
    chmod +x ./phpunit
}

function check_original_dev_location() {
    if [ "/home/michael/bash/php-skel" = "$(pwd)" ]; then
        echo "You cannot run this in the original development directory. Clone somewhere else."
        exit 1
    fi
}

check_original_dev_location

if [ $# -ne 1 ]; then
    echo "Usage: buildskel.sh [repo url]"
    exit 1
fi


echo "Cloning $1..."
NEWDIR=$(echo $1 | rev | cut -d "/" -f 1 | rev | cut -d "." -f 1)
git clone $1
if [ ! -d ${NEWDIR} ]; then
    "Cannot change to ${NEWDIR}. It must exist to continue!"
    exit 1
fi
cd ${NEWDIR}

build_skel
run_composer
setup_phpunit

echo "Completed."