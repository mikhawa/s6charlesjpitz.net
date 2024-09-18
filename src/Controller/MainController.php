<?php

namespace App\Controller;

use App\Entity\Phrase;
use App\Entity\Section;
use App\Repository\SectionRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class MainController extends AbstractController
{
    #[Route('/', name: 'main')]
    public function index(SectionRepository $sectionRepository): Response
    {
        return $this->render('main/index.html.twig', [
            'menus' => $sectionRepository->findAll(),
        ]);
    }
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
}
