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

## Création du form login

    php bin/console make:security:form-login 

```bash
 php bin/console make:security:form-login

 Choose a name for the controller class (e.g. SecurityController) [SecurityController]:
 >

 Do you want to generate a '/logout' URL? (yes/no) [yes]:
 >

 Do you want to generate PHPUnit tests? [Experimental] (yes/no) [no]:
 > yes

 created: src/Controller/SecurityController.php
 created: templates/security/login.html.twig
 created: tests/LoginControllerTest.php
 updated: config/packages/security.yaml


  Success!


 Next: Review and adapt the login template: security/login.html.twig to suit your needs.
```

### Installation de Slugify

        composer require cocur/slugify

Documentation : https://github.com/cocur/slugify

```php
// config/bundles.php
return [
    // ...
    Cocur\Slugify\Bridge\Symfony\CocurSlugifyBundle::class => ['all' => true],
];

```

```bash
php bin/console make:entity Section
 Your entity already exists! So let's add some new fields!

 New property name (press <return> to stop adding fields):
 > slug_title

 Field type (enter ? to see all types) [string]:
 >


 Field length [255]:
 > 65

 Can this field be null in the database (nullable) (yes/no) [no]:
 >

 updated: src/Entity/Section.php
 
 Et src/Entity/Section.php
 ```

```php
# ...
 
 #[ORM\Column(
        length: 65,
        unique: true
    )]
    private ?string $slug_title = null;
```

Une petite migration...

    php bin/console make:migration

    php bin/console doctrine:migrations:migrate

N'oublions de mettre les formulaires en bootstrap :

```yaml
# config/packages/twig.yaml
twig:
    form_themes: ['bootstrap_5_horizontal_layout.html.twig']
```

## installation des assets

Il faut mettre manuellement les fichiers dans le dossier `public/` et les appeler en utilisant la fonction `asset()`

dans les fichiers twigs:

```twig
{# templates/template.html.twig #}
<link rel="stylesheet" href="{{ asset('css/styles.css') }}">
<script src="{{ asset('js/scripts.js') }}"></script>
```

Pour les autres fichiers css et js, utilisons la commande suivante :

```bash
php bin/console assets:install
```


### Pour récupérer les articles


```php

#[Route('/section/{slug}', name: 'section', methods: ['GET'])]
    public function section(SectionRepository $sectionRepository, string $slug,EntityManagerInterface $em): Response
    {
        $section = $sectionRepository->findOneBy(['slug_title' => $slug]);
        if (!$section) {
            throw $this->createNotFoundException('The section does not exist');
        }
        $phrases = $section->getPhrases()->getValues();
        return $this->render('main/section.html.twig', [
            'menus' => $sectionRepository->findAll(),
            'section' => $section,
           'phrases' => $phrases,
        ]);
    }
```

### Pour la mise en page de la connexion

Qui doit fonctionner avec le menu :

`src/Controller/SecurityController.php`

```php
#...
#[Route(path: '/login', name: 'app_login')]
    public function login(AuthenticationUtils $authenticationUtils, SectionRepository $sectionRepository): Response
    {
        // get the login error if there is one
        $error = $authenticationUtils->getLastAuthenticationError();

        // last username entered by the user
        $lastUsername = $authenticationUtils->getLastUsername();

        return $this->render('security/login.html.twig', [
            'last_username' => $lastUsername,
            'error' => $error,
            'menus' => $sectionRepository->findAll(),
        ]);
    }
# ...
```

### Installation du rate-limiter

    composer require symfony/rate-limiter

Dans `# config/packages/security.yaml`

```yaml
