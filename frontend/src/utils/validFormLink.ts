import { SerializedEvent, SerializedFormData } from '../types/Event';

export default function validFormLink(event: SerializedEvent, form: SerializedFormData): string {
  const now = new Date();
  if (now < (new Date(event.start_time)) || now > (new Date(event.end_time))) {
    // Cannot sign in
    return '/form/unavailable';
  }
  // Go to sign-in form ok
  return `/form/${form.id}`;
}
