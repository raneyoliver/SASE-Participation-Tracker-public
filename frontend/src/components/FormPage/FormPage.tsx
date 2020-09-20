import * as React from 'react';
import { RouteComponentProps, navigate, useParams } from '@reach/router';
import {
  Box, TextField, Button,
} from '@material-ui/core';
import AddIcon from '@material-ui/icons/Add';
import CardWithHeader from '../CardWithHeader/CardWithHeader';
import getCSRFToken from '../../utils/getCSRFToken';

const FormPage: React.FC<RouteComponentProps> = () => {
  const [UIN, setUIN] = React.useState('');
  const handleUINChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
    const re = /^[0-9]+$/;
    if (e.target.value === '' || re.test(e.target.value)) {
        setUIN(e.target.value);
    }
  };

  const { form_id } = useParams();

  const UINValid = UIN && (UIN.length == 9);
  const formValid = UINValid;

  const handleSubmit = (): void => {
    console.log(form_id);
    if (!formValid) return;

    const body = {
      id: UIN,
      form_id: form_id
    };

    fetch('/api/users/create_form_record_if_user_exists', {
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
      else if(response.status===200) {
        navigate('/form/' + form_id + '/new_user');
      }
    });
  };

  return (
    <Box margin="10% auto" width="50%" minWidth={500}>
      <CardWithHeader title="Sign-in Form">
        <Box paddingBottom={1}>
          <TextField id="form-UIN" required error={!UINValid} label="UIN" value={UIN} onChange={handleUINChange} />
        </Box>

        <Button id="submit" variant="contained" color="secondary" disabled={!formValid} startIcon={<AddIcon />} onClick={handleSubmit}>
          Submit
        </Button>
      </CardWithHeader>
    </Box>
  );
};

export default FormPage;