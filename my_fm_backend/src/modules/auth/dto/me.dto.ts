export class MeDto {
  id: string;
  email: string;
  displayName: string;
  avatarUrl?: string;
  language: string;
  theme: 'light' | 'dark' | 'system';
  role: string;
}
