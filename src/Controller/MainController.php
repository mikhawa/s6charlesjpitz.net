<?php

namespace App\Controller;

use App\Entity\Section;
use App\Repository\SectionRepository;

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
}
