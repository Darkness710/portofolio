
<script setup>
import { ref, onMounted, onUnmounted } from 'vue'

const isOpen = ref(false)
const scrolled = ref(false)
const activeSection = ref('home')

const navLinks = [
  { id: 'home', label: 'Home' },
  { id: 'about', label: 'About' },
  { id: 'skills', label: 'Skill' },
  { id: 'projects', label: 'Projek' },
  { id: 'contact', label: 'Contact' },
]

function closeMenu() {
  isOpen.value = false
}

function handleScroll() {
  scrolled.value = window.scrollY > 20
}

let observer

onMounted(() => {
  window.addEventListener('scroll', handleScroll)

  const sections = navLinks
    .map((link) => document.getElementById(link.id))
    .filter(Boolean)

  observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          activeSection.value = entry.target.id
        }
      })
    },
    { rootMargin: '-40% 0px -55% 0px', threshold: 0 }
  )

  sections.forEach((section) => observer.observe(section))
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
  if (observer) observer.disconnect()
})
</script>

<template>
  <header
    :class="[
      'fixed inset-x-0 top-0 z-50 transition-colors duration-300',
      scrolled
        ? 'border-b border-ivory/10 bg-ink/90 backdrop-blur-md'
        : 'bg-transparent',
    ]"
  >
    <nav class="mx-auto flex max-w-5xl items-center justify-between px-6 py-4">
      <a
        href="#home"
        class="font-display text-lg tracking-tight text-ivory"
        @click="closeMenu"
      >
        yourname<span class="text-gold">.</span>
      </a>

      <!-- Menu desktop -->
      <ul class="hidden items-center gap-8 md:flex">
        <li v-for="link in navLinks" :key="link.id">
          <a
            :href="`#${link.id}`"
            :class="[
              'text-sm transition-colors',
              activeSection === link.id
                ? 'text-gold'
                : 'text-ivory/70 hover:text-ivory',
            ]"
          >
            {{ link.label }}
          </a>
        </li>
      </ul>

      <!-- Tombol hamburger (mobile) -->
      <button
        type="button"
        class="relative z-50 flex h-8 w-8 flex-col items-center justify-center gap-1.5 md:hidden"
        :aria-expanded="isOpen"
        aria-label="Buka menu navigasi"
        @click="isOpen = !isOpen"
      >
        <span
          :class="[
            'h-px w-6 bg-ivory transition-transform duration-300',
            isOpen && 'translate-y-2 rotate-45',
          ]"
        />
        <span
          :class="[
            'h-px w-6 bg-ivory transition-opacity duration-300',
            isOpen && 'opacity-0',
          ]"
        />
        <span
          :class="[
            'h-px w-6 bg-ivory transition-transform duration-300',
            isOpen && '-translate-y-2 -rotate-45',
          ]"
        />
      </button>
    </nav>

    <!-- Menu mobile (fullscreen overlay) -->
    <div
      :class="[
        'fixed inset-0 z-40 bg-ink transition-transform duration-300 ease-in-out md:hidden',
        isOpen ? 'translate-x-0' : 'translate-x-full',
      ]"
    >
      <ul class="flex h-full flex-col items-center justify-center gap-8">
        <li v-for="link in navLinks" :key="link.id">
          <a
            :href="`#${link.id}`"
            class="font-display text-2xl text-ivory"
            @click="closeMenu"
          >
            {{ link.label }}
          </a>
        </li>
      </ul>
    </div>
  </header>
</template>