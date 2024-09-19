<?php

namespace App\Controller\Admin;

use App\Entity\Phrase;
use App\Entity\Section;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\BooleanField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use EasyCorp\Bundle\EasyAdminBundle\Field\AssociationField;

class PhraseCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return Phrase::class;
    }



    public function configureFields(string $pageName): iterable
    {
        return [
           // IdField::new('id'),
            TextField::new('title'),
            BooleanField::new('published'),
            AssociationField::new('sections', 'Section')->hideOnIndex(),
        ];
    }

}
