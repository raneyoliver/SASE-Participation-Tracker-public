import { FormType } from '../Enums';

// Interface with fields needed to create a form model in rails, use this when creating forms
export interface SerializedForm {
    id: string;
    event_id: number;
    form_type: FormType;
    time_restricted: boolean;
    questions: string;
    event: {
      name: string;
      description: string;
      event_type: string;
    };
  }
