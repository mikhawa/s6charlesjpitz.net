<?php

namespace App\Entity;

use App\Repository\SectionRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: SectionRepository::class)]
class Section
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(
        type: 'integer',
        options: ['unsigned' => true]
    )]
    private ?int $id = null;

    /**
     * @var Collection<int, Phrase>
     */
    #[ORM\ManyToMany(targetEntity: Phrase::class, mappedBy: 'sections')]
    private Collection $phrases;

    #[ORM\Column(length: 60)]
    private ?string $title = null;

    public function __construct()
    {
        $this->phrases = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    /**
     * @return Collection<int, Phrase>
     */
    public function getPhrases(): Collection
    {
        return $this->phrases;
    }

    public function addPhrase(Phrase $phrase): static
    {
        if (!$this->phrases->contains($phrase)) {
            $this->phrases->add($phrase);
            $phrase->addSection($this);
        }

        return $this;
    }

    public function removePhrase(Phrase $phrase): static
    {
        if ($this->phrases->removeElement($phrase)) {
            $phrase->removeSection($this);
        }

        return $this;
    }

    public function getTitle(): ?string
    {
        return $this->title;
    }

    public function setTitle(string $title): static
    {
        $this->title = $title;

        return $this;
    }
}
