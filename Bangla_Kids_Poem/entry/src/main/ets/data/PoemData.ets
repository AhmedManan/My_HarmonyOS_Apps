// PoemData.ts
import poets from '../data/poets.json';
import poems from '../data/poems.json';

export interface Poet {
  id: number;
  name: string;
  birthYear: number | string;
  deathYear: number | string;
  bio: string;
  imageUrl?: string;
}

export interface Poem {
  id: number;
  title: string;
  poetId: number;
  content: string;
  yearWritten?: string | null;  // Accept both string and null
  tags?: string[];
}

// Cast the imported JSON to the correct types
export const poetData: Poet[] = poets as Poet[];
export const poemData: Poem[] = poems as Poem[];

// Utility functions remain exactly the same
export function getPoemById(id: number): Poem | undefined {
  return poemData.find(poem => poem.id === id);
}

export function getPoetById(id: number): Poet | undefined {
  return poetData.find(poet => poet.id === id);
}

export function getPoetByPoemId(poemId: number): Poet | undefined {
  const poem = getPoemById(poemId);
  return poem ? getPoetById(poem.poetId) : undefined;
}

export function getPoemsByPoetId(poetId: number): Poem[] {
  return poemData.filter(poem => poem.poetId === poetId);
}