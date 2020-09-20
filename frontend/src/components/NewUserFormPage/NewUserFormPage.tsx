import * as React from 'react';
import { RouteComponentProps, navigate, useParams } from '@reach/router';
import {
  Box, TextField, Button,
} from '@material-ui/core';
import AddIcon from '@material-ui/icons/Add';
import CardWithHeader from '../CardWithHeader/CardWithHeader';
import { User } from '../../types/User';
import getCSRFToken from '../../utils/getCSRFToken';

const NewUserFormPage: React.FC<RouteComponentProps> = () => {
  const [UIN, setUIN] = React.useState('');
  const handleUINChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
    const re = /^[0-9]+$/;
    if (e.target.value === '' || re.test(e.target.value)) {
        setUIN(e.target.value);
    }
  };

  const [firstName, setFirstName] = React.useState('');
  const handleFirstNameChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
        setFirstName(e.target.value);
  };

  const [lastName, setLastName] = React.useState('');
  const handleLastNameChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
        setLastName(e.target.value);
  };

  const [major, setMajor] = React.useState('');
  const handleMajorChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
        setMajor(e.target.value);
  };

  const [email, setEmail] = React.useState('');
  const handleEmailChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
        setEmail(e.target.value);
  };

  const [graduationYear, setgraduationYear] = React.useState('');
  const handleGraduationYearChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
    const re = /^[0-9]+$/;
    if (e.target.value === '' || re.test(e.target.value)) {
        setgraduationYear(e.target.value);
    }
  };

  const [phoneNumber, setPhoneNumber] = React.useState('');
  const handlePhoneNumberChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
        setPhoneNumber(e.target.value);
  };

  const { form_id } = useParams();

  const UINValid = UIN && (UIN.length == 9);
  const graduationYearValid = graduationYear && (graduationYear.length == 4);
  const formValid = UINValid && firstName && lastName && major && graduationYearValid && email;

  const handleSubmit = (): void => {
    if (!formValid) return;

    const userBody: User = {
      id: UIN,
      first_name: firstName,
      last_name: lastName,
      major,
      graduation_year: parseInt(graduationYear),
      email,
      phone_number: phoneNumber
    };

    const body = {
      user: userBody,
      form_id: form_id
    }

    fetch('/api/users/create_user_and_form_record', {
      method: 'POST',
      headers: {
        'Content-type': 'application/json',
        'X-CSRF-Token': getCSRFToken(),
      },
      body: JSON.stringify(body),
    }).then((response) => {
      console.log(response.status);
      if(response.status === 201) {
        navigate('/form/confirm_submission');
      }
    });
  };

  return (
    <Box margin="10% auto" width="50%" minWidth={500}>
      <CardWithHeader title="New User Sign-in Form">
        <Box paddingBottom={1}>
          <TextField id="new-user-UIN" required error={!UINValid} label="UIN" value={UIN} onChange={handleUINChange} />
        </Box>

        <Box paddingBottom={1}>
          <TextField id="new-user-first-name" required error={!firstName} label="First Name" value={firstName} onChange={handleFirstNameChange} />
        </Box>

        <Box paddingBottom={1}>
          <TextField id="new-user-last-name" required error={!lastName} label="Last Name" value={lastName} onChange={handleLastNameChange} />
        </Box>

        <Box paddingBottom={1}>
          <TextField id="new-user-major" required error={!major} label="Major" value={major} onChange={handleMajorChange} />
        </Box>

        <Box paddingBottom={1}>
          <TextField id="new-user-graduation-year" required error={!graduationYearValid} label="Graduation Year" value={graduationYear} onChange={handleGraduationYearChange} />
        </Box>

        <Box paddingBottom={1}>
          <TextField id="new-user-email" required error={!email} label="Email Address" value={email} onChange={handleEmailChange} />
        </Box>

        <Box paddingBottom={1}>
          <TextField id="new-user-phone-number" label="Phone Number" value={phoneNumber} onChange={handlePhoneNumberChange} />
        </Box>

        <Button id="submit" variant="contained" color="secondary" disabled={!formValid} startIcon={<AddIcon />} onClick={handleSubmit}>
          Submit
        </Button>
      </CardWithHeader>
    </Box>
  );
};

export default NewUserFormPage;