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

Création des tables
        
    php bin/console make:migration

    php bin/console doctrine:migrations:migrate

Admin est protégé par un firewall

`config/packages/security.yaml`

```yaml
security:
    # https://symfony.com/doc/current/security.html#registering-the-user-hashing-passwords
    password_hashers:
        Symfony\Component\Security\Core\User\PasswordAuthenticatedUserInterface: 'auto'
    # https://symfony.com/doc/current/security.html#loading-the-user-the-user-provider
    providers:
        # used to reload user from session & other features (e.g. switch_user)
        app_user_provider:
            entity:
                class: App\Entity\User
                property: username
    firewalls:
        dev:
            pattern: ^/(_(profiler|wdt)|css|images|js)/
            security: false
        main:
            lazy: true
            provider: app_user_provider

            # activate different ways to authenticate
            # https://symfony.com/doc/current/security.html#the-firewall

            # https://symfony.com/doc/current/security/impersonating_user.html
            # switch_user: true

    # Easy way to control access for large sections of your site
    # Note: Only the *first* access control that matches will be used
    access_control:
        - { path: ^/admin, roles: ROLE_ADMIN }
        # - { path: ^/profile, roles: ROLE_USER }

when@test:
    security:
        password_hashers:
            # By default, password hashers are resource intensive and take time. This is
            # important to generate secure password hashes. In tests however, secure hashes
            # are not important, waste resources and increase test times. The following
            # reduces the work factor to the lowest possible values.
            Symfony\Component\Security\Core\User\PasswordAuthenticatedUserInterface:
                algorithm: auto
                cost: 4 # Lowest possible value for bcrypt
                time_cost: 3 # Lowest possible value for argon
                memory_cost: 10 # Lowest possible value for argon

```

# Création de la page d'accueil

    php bin/console make:controller HomeController

### suppression de asset mapper

    composer remove symfony/ux-turbo symfony/asset-mapper symfony/stimulus-bundle

# Création d'une administration

    php bin/console make:admin:dashboard

```bash
 Which class name do you prefer for your Dashboard controller? [DashboardController]:
 > AdminController

 In which directory of your project do you want to generate "AdminController"? [src/Controller/Admin/]:
 >



 [OK] Your dashboard class has been successfully generated.


 Next steps:
 * Configure your Dashboard at "src/Controller/Admin/AdminController.php"
 * Run "make:admin:crud" to generate CRUD controllers and link them from the Dashboard.

```