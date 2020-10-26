// A Enum to restrict the value of form_type
export enum FormType {
  SIGN_IN = 'sign-in',
  RSVP = 'RSVP',
}

// Map from backend form types to a human-friendly name
export const formattedFormType = new Map<FormType, string>([
  [FormType.SIGN_IN, 'Sign-in Form'],
  [FormType.RSVP, 'RSVP Form'],
]);

// A Enum to restrict the value of event_type
export enum EventType {
  gbm = 'GBM',
  socials = 'Socials',
  mentor = 'Mentor/Mentee',
  volunteer = 'Volunteer',
  profitshare = 'Profit Share',
}
