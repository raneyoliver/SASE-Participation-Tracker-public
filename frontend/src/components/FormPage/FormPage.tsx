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
    const re = /^[0-9]{0,9}$/;
    if (re.test(e.target.value)) {
      setUIN(e.target.value);
    }
  };

  const { formId } = useParams();

  const UINValid = UIN.length === 9;
  const formValid = UINValid;

  const handleSubmit = (): void => {
    if (!formValid) return;

    const body = {
      id: UIN,
      form_id: formId,
    };

    fetch('/api/users/handle_identification', {
      method: 'POST',
      headers: {
        'Content-type': 'application/json',
        'X-CSRF-Token': getCSRFToken(),
      },
      body: JSON.stringify(body),
    }).then((response) => {
      if (response.status === 201) {
        navigate('/form/confirm_submission');
      } else if (response.status === 200) {
        navigate(`/form/${formId}/new_user/${UIN}`);
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
