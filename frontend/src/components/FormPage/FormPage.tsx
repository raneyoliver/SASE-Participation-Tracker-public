import * as React from 'react';
// import { useHistory } from 'react-router-dom';
import { RouteComponentProps, navigate, useParams } from '@reach/router';
import {
  Box, TextField, Button, Typography,
} from '@material-ui/core';
import AddIcon from '@material-ui/icons/Add';
import CardWithHeader from '../CardWithHeader/CardWithHeader';
import getCSRFToken from '../../utils/getCSRFToken';
import { SerializedForm } from '../../types/Form';
import { FormUser } from '../../types/FormUser';

const FormPage: React.FC<RouteComponentProps> = () => {
  const { formId } = useParams();

  const [loading, setLoading] = React.useState(true);

  const [form, setForm] = React.useState<SerializedForm>();
  React.useEffect(() => {
    fetch(`/api/forms/${formId}`).then((response) => {
      if (response.status === 404) {
        window.location.href = '/form/error';
      }
      return response.json();
    }).then((response: SerializedForm) => {
      setForm(response);
    }).finally(() => setLoading(false));
  }, [formId]);

  const [UIN, setUIN] = React.useState('');
  const handleUINChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
    const re = /^[0-9]{0,9}$/;
    if (re.test(e.target.value)) {
      setUIN(e.target.value);
    }
  };

  const UINValid = UIN.length === 9;
  const formValid = UINValid;

  const handleSubmit = (): void => {
    if (!formValid) return;

    const body = {
      id: UIN,
      form_id: formId,
    };

    const formUserBody: FormUser = {
      form_id: formId,
      user_id: UIN,
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
        fetch('/api/form_users/create', {
          method: 'POST',
          headers: {
            'Content-type': 'application/json',
            'X-CSRF-Token': getCSRFToken(),
          },
          body: JSON.stringify(formUserBody),
        }).then((response2) => {
          if (response2.status === 201) {
            navigate('/form/confirm_submission');
          } else if (response2.status === 200) {
            navigate('/form/confirm_update');
          }
        });
      } else if (response.status === 200) {
        navigate(`/form/${formId}/new_user/${UIN}`);
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
    <Box margin="10% auto" width="50%" minWidth={500}>
      <CardWithHeader title={`Sign-in Form for ${form.event.name}`}>
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
