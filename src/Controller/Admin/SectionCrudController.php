<?php

namespace App\Controller\Admin;

use App\Entity\Section;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\IdField;
use EasyCorp\Bundle\EasyAdminBundle\Field\SlugField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextEditorField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;

class SectionCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return Section::class;
    }


    public function configureFields(string $pageName): iterable
    {
        return [
           // IdField::new('id'),
            TextField::new('title'),
            SlugField::new('slug_title')->setTargetFieldName('title'),
            NumberField::new('statistique', 'Statistique')
                ->setTextAlign('center')
            ->setTemplatePath('admin/fields/statistique.html.twig'),
        ];
    }

}
