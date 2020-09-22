// Interface with fields needed to create an user model in rails, use this when creating users
export interface User {
    id: string;
    first_name: string;
    last_name: string;
    major: string;
    graduation_year: number;
    email: string;
    phone_number: string;
  }
