# Version s6.4 de charlesjpitz.net

    symfony new s6charlesjpitz.net --version=lts webapp

Installation de amphp

    composer require amphp/amp

Installation de EasyAdmin

    composer require easycorp/easyadmin-bundle

Création d'entité

        php bin/console make:entity Section
        php bin/console make:entity Phrase

Création d'un utilisateur

        php bin/console make:user
    

Création de la base de données

        php bin/console doctrine:database:create
        php bin/console doctrine:schema:update --force
