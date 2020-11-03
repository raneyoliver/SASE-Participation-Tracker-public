import * as React from 'react';
import { RouteComponentProps, navigate, useParams } from '@reach/router';
import { makeStyles } from '@material-ui/core/styles';
import {
  Box, TextField, Button, Typography, FormControl, NativeSelect, InputLabel, Tooltip,
} from '@material-ui/core';
import AddIcon from '@material-ui/icons/Add';
import CardWithHeader from '../CardWithHeader/CardWithHeader';
import { User } from '../../types/User';
import { FormUser } from '../../types/FormUser';
import getCSRFToken from '../../utils/getCSRFToken';
import UserAlreadyExistsDialog from './UserAlreadyExistsDialog/UserAlreadyExistsDialog';

const NewUserPage: React.FC<RouteComponentProps> = () => {
  const { formId, UIN } = useParams();

  const [loading, setLoading] = React.useState(true);

  React.useEffect(() => {
    const re = /^[0-9]{9}$/;
    if (!re.test(UIN)) {
      window.location.href = '/form/error';
    }
    fetch(`/api/forms/${formId}`).then((response) => {
      if (response.status === 404) {
        window.location.href = '/form/error';
      }
    }).finally(() => setLoading(false));
  }, [UIN, formId]);

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

  const [confirmationEmail, setConfirmationEmail] = React.useState('');
  const handleConfirmationEmailChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
    setConfirmationEmail(e.target.value);
  };

  // had to style the dropdown manually
  const useStyles = makeStyles(() => ({
    formControl: {
      minWidth: 180,
    },
  }));

  const classes = useStyles();
  // eslint-disable-next-line jsx-a11y/control-has-associated-label
  const gradYearOptions = [<option value="" key={null} />];
  const currentYear = new Date().getFullYear();
  for (let year = currentYear - 1; year <= currentYear + 6; year++) {
    gradYearOptions.push(<option value={year} key={year}>{year}</option>);
  }
  const [graduationYear, setGraduationYear] = React.useState('');
  const handleGraduationYearChange = (e: React.ChangeEvent<HTMLSelectElement>): void => {
    setGraduationYear(e.target.value);
  };

  // parse passed in value and format it for the user (xxx) xxx-xxxx
  const normalizePhoneNumber = (newPhoneNumber: string): string => {
    if (newPhoneNumber.length < 4) return newPhoneNumber;
    if (newPhoneNumber.length < 7) return `(${newPhoneNumber.slice(0, 3)}) ${newPhoneNumber.slice(3)}`;
    return `(${newPhoneNumber.slice(0, 3)}) ${newPhoneNumber.slice(3, 6)}-${newPhoneNumber.slice(6, 10)}`;
  };

  const [phoneNumber, setPhoneNumber] = React.useState('');
  const handlePhoneNumberChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
    // remove layout from form input
    const newPhoneNumber = e.target.value.replace(/[^\d]/g, '');
    const re = /^[0-9]{0,10}$/;
    if (re.test(newPhoneNumber)) {
      setPhoneNumber(newPhoneNumber);
    }
  };

  const [dialogOpen, setDialogOpen] = React.useState(false);
  const handleDialogClose = (): void => {
    setDialogOpen(false);
  };

  // eslint-disable-next-line no-control-regex
  const re = /^(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])$/;
  const validEmail = re.test(email);
  const validConfirmationEmail = (email === confirmationEmail) && email;
  const validPhoneNumber = phoneNumber.length === 0 || phoneNumber.length === 10;
  const formValid = (firstName && lastName && graduationYear && major && email
    && validEmail && validConfirmationEmail && validPhoneNumber);

  const handleSubmit = (): void => {
    if (!formValid) return;

    const userBody: User = {
      id: UIN,
      first_name: firstName,
      last_name: lastName,
      major,
      graduation_year: parseInt(graduationYear, 10),
      email,
      phone_number: phoneNumber,
    };

    const formUserBody: FormUser = {
      form_id: formId,
      user_id: UIN,
    };

    const body = {
      user: userBody,
      form_id: formId,
    };

    fetch('/api/users/create', {
      method: 'POST',
      headers: {
        'Content-type': 'application/json',
        'X-CSRF-Token': getCSRFToken(),
      },
      body: JSON.stringify(body),
    }).then((response) => {
      if (response.status === 201) {
        fetch('/api/form_users/create', {
          method: 'POST',
          headers: {
            'Content-type': 'application/json',
            'X-CSRF-Token': getCSRFToken(),
          },
          body: JSON.stringify(formUserBody),
        }).then((response2) => {
          if (response2.status === 403) {
            window.location.href = '/form/unavailable';
          }
          if (response2.status === 201) {
            navigate('/form/confirm_submission');
          }
        });
      } else if (response.status === 409) {
        setDialogOpen(true);
      }
    });
  };

  if (loading) {
    return (
      <Typography>
        Loading...
      </Typography>
    );
  }

  return (
    <Box>
      <CardWithHeader title="New User Sign-in Form" fixWidth>
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
          <FormControl required className={classes.formControl} error={!graduationYear}>
            <InputLabel htmlFor="new-user-graduation-year">Graduation Year</InputLabel>
            <NativeSelect
              value={graduationYear}
              onChange={handleGraduationYearChange}
              name="Graduation Year"
              inputProps={{
                name: 'graduation-year',
                id: 'new-user-graduation-year',
              }}
            >
              {gradYearOptions}
            </NativeSelect>
          </FormControl>
        </Box>

        <Box paddingBottom={1}>
          <Tooltip title={validEmail ? '' : 'Fill in a valid email address.'} placement="right">
            <TextField id="new-user-email" required error={!validEmail} label="Email Address" value={email} onChange={handleEmailChange} />
          </Tooltip>
        </Box>

        <Box paddingBottom={1}>
          <Tooltip title={validConfirmationEmail ? '' : 'Email confirmation field must match email address.'} placement="right">
            <TextField id="new-user-confirmation-email" required error={!validConfirmationEmail} label="Confirm Email" value={confirmationEmail} onChange={handleConfirmationEmailChange} />
          </Tooltip>
        </Box>

        <Box paddingBottom={1}>
          <Tooltip title={validPhoneNumber ? '' : 'Fill in a valid phone number or leave blank.'} placement="right">
            <TextField id="new-user-phone-number" error={!validPhoneNumber} label="Phone Number" value={normalizePhoneNumber(phoneNumber)} onChange={handlePhoneNumberChange} />
          </Tooltip>
        </Box>

        <Tooltip title={formValid ? '' : 'Fill in all fields in red with valid input to submit.'}>
          <span>
            <Button id="submit" variant="contained" color="secondary" disabled={!formValid} startIcon={<AddIcon />} onClick={handleSubmit}>
              Submit
            </Button>
          </span>
        </Tooltip>
      </CardWithHeader>
      <UserAlreadyExistsDialog open={dialogOpen} handleClose={handleDialogClose} />
    </Box>
  );
};

export default NewUserPage;
