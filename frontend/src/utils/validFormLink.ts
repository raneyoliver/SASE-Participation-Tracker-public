import { SerializedEvent, SerializedFormData } from '../types/Event';

export default function validFormLink(event: SerializedEvent, form: SerializedFormData): string {
  const now = new Date();
  const outsideEventInterval = now < (new Date(event.start_time))
                            || now > (new Date(event.end_time));
  const afterEventStart = now > (new Date(event.start_time));
  const isSignIn = form.form_type.toString() === 'sign-in';
  const isRSVP = form.form_type.toString() === 'RSVP';

  if ((isSignIn && outsideEventInterval) || (isRSVP && afterEventStart)) {
    // Cannot sign in - outside of event interval for sign-in or too late to RSVP
    return '/form/unavailable';
  }
  // Go to sign-in form ok
  return `/form/${form.id}`;
}
