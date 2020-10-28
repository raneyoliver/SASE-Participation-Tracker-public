import * as React from 'react';
// import { useHistory } from 'react-router-dom';
import { RouteComponentProps, navigate, useParams } from '@reach/router';
import {
  Box, TextField, Button, Typography, Card,
} from '@material-ui/core';
import AddIcon from '@material-ui/icons/Add';
import CardWithHeader from '../CardWithHeader/CardWithHeader';
import getCSRFToken from '../../utils/getCSRFToken';
import { SerializedForm } from '../../types/Form';
import { FormUser } from '../../types/FormUser';
import { formattedFormType } from '../../Enums';

const FormPage: React.FC<RouteComponentProps> = () => {
  const { formId } = useParams();

  const [loading, setLoading] = React.useState(true);

  const [form, setForm] = React.useState<SerializedForm>();
  React.useEffect(() => {
    fetch(`/api/forms/${formId}`).then((response) => {
      if (response.status === 404) window.location.href = '/form/error';
      else if (response.status === 403) window.location.href = '/form/unavailable';
      else return response.json();
      return undefined;
    }).then((response: SerializedForm) => {
      if (response) {
        setForm(response);
        setLoading(false);
      }
    }).catch(() => {
      window.location.href = '/form/error';
    });
  }, [formId]);

  const [UIN, setUIN] = React.useState('');
  const handleUINChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
    const re = /^[0-9]{0,9}$/;
    if (re.test(e.target.value)) {
      setUIN(e.target.value);
    }
  };

  const [submitting, setSubmitting] = React.useState(false);
  const [submissionError, setSubmissionError] = React.useState(false);

  const UINValid = UIN.length === 9;
  const formValid = UINValid;

  const handleSubmit = (): void => {
    if (!formValid) return;
    setSubmissionError(false);
    setSubmitting(true);

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
    }).catch(() => {
      setSubmitting(false);
      setSubmissionError(true);
    });
  };

  if (loading) {
    return (
      <Typography>
        Loading...
      </Typography>
    );
  }

  const descriptionBlock = (
    <Card>
      <Box padding={1}>
        <Typography variant="body2">
          {form.event.description}
        </Typography>
      </Box>
    </Card>
  );

  const submissionErrorText = submissionError ? (
    <Typography color="error">
      There was an error submitting the form. Please try again.
    </Typography>
  ) : null;

  return (
    <CardWithHeader title={`${formattedFormType.get(form.form_type)} for ${form.event.name} (${form.event.event_type || 'No Type Provided for'} Event)`} fixWidth>

      {form.event.description !== '' && descriptionBlock}

      <Box paddingBottom={1}>
        <TextField id="form-UIN" required error={!UINValid} label="UIN" value={UIN} onChange={handleUINChange} />
      </Box>

      {submissionErrorText}
      <Button id="submit" variant="contained" color="secondary" disabled={!formValid || submitting} startIcon={<AddIcon />} onClick={handleSubmit}>
        Submit
      </Button>
    </CardWithHeader>
  );
};

export default FormPage;
