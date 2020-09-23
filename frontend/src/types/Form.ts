// Interface with fields needed to create a form model in rails, use this when creating forms
export interface Form {
    id: string;
    event_id: number;
    start_time: string;
    form_type: string;
    questions: string;
  }
